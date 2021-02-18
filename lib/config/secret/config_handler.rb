module Config
  module Sources
    class ConfigHandler < Psych::TreeBuilder
    # При анализе yaml файла заполняет переменные значениями из Vault
      def scalar(value, anchor, tag, plain, quoted, style)
        vault_regex = /vault:/
        translated = if value.match(vault_regex)
                       query = value.gsub(vault_regex, '')
                       Config::Secret.read_string(query)
                     else
                       value
                     end
        super translated, anchor, tag, plain, quoted, style
      end
    end
  end
end