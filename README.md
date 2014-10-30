# Openssl::BetterDefaults

Overrides Ruby's default OpenSSL parameters to be more secure.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openssl-better_defaults'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openssl-better_defaults

## Usage

```ruby
require 'openssl/better_defaults'
```

Congratulations, you are no longer using insecure SSL/TLS cipher suites.

## Contributing

1. Fork it ( https://gitlab.com/duckinator/openssl-better_defaults/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
