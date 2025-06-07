# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby gem implementing the SKI combinator calculus system. The project uses:
- Ruby (>= 2.7.0)
- Minitest for testing
- RuboCop for code linting
- Bundler for dependency management

## Common Development Commands

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake test
# or
bundle exec rake

# Run a specific test file
bundle exec ruby test/test_ski.rb

# Run linting
bundle exec rubocop

# Run tests and linting (default task)
bundle exec rake

# Build the gem
bundle exec rake build

# Install gem locally
bundle exec rake install

# Release to RubyGems (requires permissions)
bundle exec rake release
```

## Project Structure

- `lib/ski.rb` - Main module with SKI combinator implementations
- `lib/ski/version.rb` - Version constant
- `test/` - Minitest test files
- `ski.gemspec` - Gem specification
- `Rakefile` - Rake tasks for testing and building

## Architecture Notes

The gem implements the three fundamental combinators of SKI calculus:
- **S combinator**: `S x y z = x z (y z)`
- **K combinator**: `K x y = x`
- **I combinator**: `I x = x`

These are implemented as Ruby lambda functions in the `Ski::Combinators` module, allowing for functional composition and curried application.