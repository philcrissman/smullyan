# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby gem implementing combinators from Raymond Smullyan's "To Mock a Mockingbird". The project uses:
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

- `lib/smullyan.rb` - Main module with combinator implementations (Birds module)
- `lib/smullyan/version.rb` - Version constant
- `test/test_smullyan.rb` - Minitest test files
- `smullyan.gemspec` - Gem specification
- `Rakefile` - Rake tasks for testing and building

## Architecture Notes

The gem implements combinators from combinatory logic, each with both a letter name and a bird name from Smullyan's book:

### Core SKI Combinators:
- **S combinator (Starling)**: `S x y z = x z (y z)`
- **K combinator (Kestrel)**: `K x y = x`
- **I combinator (Identity/Idiot)**: `I x = x`

### Additional Combinators:
- **B combinator (Bluebird)**: `B x y z = x (y z)` - function composition
- **C combinator (Cardinal)**: `C x y z = x z y` - argument flip
- **W combinator (Warbler)**: `W x y = x y y` - duplication
- **M combinator (Mockingbird)**: `M x = x x` - self-application
- **Y combinator (Why/Sage)**: Fixed-point combinator for recursion

These are implemented as Ruby lambda functions in the `Smullyan::Birds` module, with both single-letter names (S, K, I, etc.) and bird names (Starling, Kestrel, Identity, etc.) available.
