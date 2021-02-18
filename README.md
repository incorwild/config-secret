# Config::Secret



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'config-secret'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install config-secret

## Usage
Create an initializer `config.rb`:

```ruby
Config::Secret.configure do |c|
  # The address of the Vault server. Default: ENV["VAULT_ADDR"].
  c.address = 'https://vault.corp'
  
  # The token to communicate with the Vault server.
  # Default: ENV["VAULT_TOKEN"].
  vault.token = "abcd1234"
end

```

## Adding secrets

Given, you have an input yml that looks like:

```yaml
development:
  aws:
    access_id: 'XXX'
staging:
  aws:
    access_id: vault:/secret/staging/aws/access_id
production:
  aws:
    access_id: vault:/secret/production/aws/access_id
```

Note that this does not actually write back to the file, and it is upto you to use this result as you want. One strategy is to store these into the Rails configuration object when Rails initializes, so you will have it available to your process, but you won't need to write any secret anywhere. Bye bye to leaky ENV variables!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/incorwild/config-secret.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
