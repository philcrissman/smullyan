# frozen_string_literal: true

require_relative "ski/version"

module Ski
  class Error < StandardError; end
  
  # SKI combinator implementations
  module Combinators
    # S combinator: S x y z = x z (y z)
    S = ->(x) { ->(y) { ->(z) { x.call(z).call(y.call(z)) } } }
    
    # K combinator: K x y = x
    K = ->(x) { ->(y) { x } }
    
    # I combinator: I x = x
    I = ->(x) { x }
  end
end