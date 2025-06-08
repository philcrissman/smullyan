# frozen_string_literal: true

require_relative "cardinal"
require_relative "starling"
require_relative "identity"

module Smullyan
  module Birds
    # The Warbler - duplicates its argument
    # Warbler x y = x y y
    # Can be derived as: W = C S I
    Warbler = C.call(S).call(I)
    
    # Direct implementation for comparison/efficiency
    Warbler_direct = ->(x) { ->(y) { x.call(y).call(y) } }
    
    # Traditional combinator name
    W = Warbler         # W combinator
    W_direct = Warbler_direct
  end
end