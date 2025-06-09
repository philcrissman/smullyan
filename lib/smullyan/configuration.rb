# frozen_string_literal: true

module Smullyan
  # Configuration for selecting combinator implementations
  class Configuration
    attr_accessor :use_direct_implementation

    def initialize
      @use_direct_implementation = {
        b: false,  # Bluebird
        c: false,  # Cardinal
        w: false,  # Warbler
        m: false,  # Mockingbird
        l: false   # Lark
      }
    end

    # Configure specific combinators
    def use_direct(combinator, value = true)
      key = combinator.to_s.downcase.to_sym
      if @use_direct_implementation.key?(key)
        @use_direct_implementation[key] = value
      else
        raise ArgumentError, "Unknown combinator: #{combinator}"
      end
    end

    # Configure all combinators at once
    def use_all_direct(value = true)
      @use_direct_implementation.each_key do |key|
        @use_direct_implementation[key] = value
      end
    end

    # Check if a combinator should use direct implementation
    def direct?(combinator)
      key = combinator.to_s.downcase.to_sym
      @use_direct_implementation[key] || false
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end