module Config
  module Sources
    class YAMLSource
      attr_accessor :path

      def initialize(path)
        @path = path.to_s
      end

      def load
        if @path && File.exist?(@path.to_s)
          handler = ConfigHandler.new
          parser = Psych::Parser.new(handler)
          parser.parse(ERB.new(IO.read(@path)).result)
          result = handler.root.to_ruby.first
        end
        result || {}
      end
    end
  end
end