lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config/secret/version'

Gem::Specification.new do |spec|
  spec.name          = 'config-secret'
  spec.version       = Config::Secret::VERSION
  spec.authors       = ['Andrew Pankov']
  spec.email         = ['incorwild@gmail.com']

  spec.summary       = 'Rails plugin for interacting with Vault by HashiCorp in Config gem.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/incorwild/config-secret'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'vault', '~> 0.10'
  spec.add_dependency 'config', '~> 1.0.0'
  spec.add_development_dependency 'bundler', '~> 1.17'
end
