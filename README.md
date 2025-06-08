# Smullyan

A Ruby implementation of combinators from Raymond Smullyan's "To Mock a Mockingbird".

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smullyan'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install smullyan

## Usage

```ruby
require 'smullyan'

# Using SKI combinator names
s = Smullyan::Birds::S
k = Smullyan::Birds::K  
i = Smullyan::Birds::I

# Or use the bird names!
kestrel = Smullyan::Birds::Kestrel      # K combinator
starling = Smullyan::Birds::Starling    # S combinator
mockingbird = Smullyan::Birds::Mockingbird # M combinator

# Example: Identity function derived from S and K
identity = s.call(k).call(k)
identity.call(42) # => 42

# Example: Function composition with the Bluebird
bluebird = Smullyan::Birds::Bluebird
double = ->(x) { x * 2 }
increment = ->(x) { x + 1 }
double_after_increment = bluebird.call(double).call(increment)
double_after_increment.call(5) # => 12

# Example: Y combinator for recursion
why = Smullyan::Birds::Why
factorial = why.call(->(f) {
  ->(n) { n <= 1 ? 1 : n * f.call(n - 1) }
})
factorial.call(5) # => 120
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/philcrissman/smullyan.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
