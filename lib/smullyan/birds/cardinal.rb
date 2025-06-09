# frozen_string_literal: true

require_relative 'starling'
require_relative 'bluebird'
require_relative 'kestrel'

module Smullyan
  module Birds
    # The Cardinal - flips the order of arguments
    # Cardinal x y z = x z y
    
    # Derived implementation: C = S (B B S) (K K)
    C_derived = S.call(B.call(B).call(S)).call(K.call(K))
    
    # Direct implementation for comparison/efficiency
    C_direct = ->(x) { ->(y) { ->(z) { x.call(z).call(y) } } }
    
    # Default to derived implementation for backward compatibility
    Cardinal = C_derived
    C = Cardinal
  end
end
