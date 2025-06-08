# frozen_string_literal: true

require_relative "starling"
require_relative "identity"

module Smullyan
  module Birds
    # The Mockingbird - self-application
    # Mockingbird x = x x
    # Can be derived as: M = S I I
    Mockingbird = S.call(I).call(I)
    
    # Direct implementation for comparison/efficiency
    Mockingbird_direct = ->(x) { x.call(x) }
    
    # Traditional combinator name
    M = Mockingbird         # M combinator
    M_direct = Mockingbird_direct
  end
end