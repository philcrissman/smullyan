# frozen_string_literal: true

require_relative 'cardinal'
require_relative 'starling'
require_relative 'identity'

module Smullyan
  module Birds
    # The Warbler - duplicates its argument
    # Warbler x y = x y y

    # Derived implementation: W = C S I
    W_derived = C.call(S).call(I)

    # Direct implementation for comparison/efficiency
    W_direct = ->(x) { ->(y) { x.call(y).call(y) } }

    # Default to derived implementation for backward compatibility
    Warbler = W_derived
    W = Warbler
  end
end
