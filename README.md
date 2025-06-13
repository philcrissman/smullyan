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
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/philcrissman/smullyan.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
