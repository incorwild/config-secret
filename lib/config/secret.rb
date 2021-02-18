require 'config'
require 'vault'

require_relative 'secret/configurable'
require_relative 'secret/version'
require_relative 'secret/config_handler'
require_relative 'sources/yaml_source'

module Config
  module Secret
    class << self
      attr_reader :client

      def setup!
        Vault.setup!

        @client = Vault.client
        @client.class.instance_eval do
          include Config::Secret::Configurable
        end
        self
      end

      def config_setup(*files)
        Config.load_and_set_settings(files)
      end

      # Delegate all methods to the client object, essentially making the module
      # object behave like a {Vault::Client}.
      def method_missing(m, *args, &block)
        if client.respond_to?(m)
          client.public_send(m, *args, &block)
        else
          super
        end
      end

      # Delegating `respond_to` to the {Vault::Client}.
      def respond_to_missing?(m, include_private = false)
        client.respond_to?(m, include_private) || super
      end

      def read_string(key)
        read(key).data[:value]
      end

      def read(query)
        client.with_retries(Vault::HTTPConnectionError) do
          val = client.logical.read(query)
          raise "VaultError: No secret was stored for #{query}" unless val
          val
        end
      end
    end
  end
end

Config::Secret.setup!
