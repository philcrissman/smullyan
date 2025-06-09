# frozen_string_literal: true

require_relative 'starling'
require_relative 'identity'

module Smullyan
  module Birds
    # The Mockingbird - self-application
    # Mockingbird x = x x
    
    # Derived implementation: M = S I I
    M_derived = S.call(I).call(I)
    
    # Direct implementation for comparison/efficiency
    M_direct = ->(x) { x.call(x) }
    
    # Default to derived implementation for backward compatibility
    Mockingbird = M_derived
    M = Mockingbird
  end
end
