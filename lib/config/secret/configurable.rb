module Config
  module Secret
    module Configurable
      include Vault::Configurable

      def files
        @files
      end

      def files=(val)
        @files = val
      end
    end
  end
end
