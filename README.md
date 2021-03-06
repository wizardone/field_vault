# FieldVault

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/field_vault`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'field_vault'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install field_vault

## Usage
In the most simple form field_vault will encrypt your fields in base64
encoding
```ruby
class UserDetails < ApplicationRecord
  include FieldVault
  field_vault :passport_number, :drivers_license
end
```
Once stored in the database the fields are encrypted
```ruby
  user_details.passport_number = '123321'
  user_details.save!

  user_details.passport_number
  => 'some_base_64_encoded_string'
```

FieldVault automatically defines methods to fetch the decoded values for whatever you have encoded.
Those methods are prefixed with `decoded_`
```ruby
  user_details.decoded_passport_number
  => '123321'
```

Think you need something custom? Write your own class to take care of this. All that `FieldVault` expects
is a class that responds to `encode` and `decode` methods:

```ruby
class MyCustomEncoder
  def encode
  end

  def decode
  end
end

class UserDetails < ApplicationRecord
  include FieldVault
  field_vault :passport_number, :drivers_license, encoder: MyCustomEncoder.new
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/field_vault. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FieldVault project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/field_vault/blob/master/CODE_OF_CONDUCT.md).
