# Reredos

Reredos is the email address validator, which is free from [ReDoS Attack](https://www.owasp.org/index.php/Regular_expression_Denial_of_Service_-_ReDoS).

You can examine if an email address is based on [RFC1035](https://www.ietf.org/rfc/rfc1035.txt) and [RFC5321](https://www.ietf.org/rfc/rfc5321.txt).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reredos'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reredos

## Usage
```ruby
Reredos.valid_email?('user@example.com')
# => true

Reredos.valid_email?('user@@example.com')
# => false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/expajp/reredos. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Reredos project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/reredos/blob/master/CODE_OF_CONDUCT.md).

## Release Notes
### 0.1.1 - April 26, 2019
* Fixed a bug, that it accepted strings including new line

### 0.1.0 - April 24, 2019
* First Version