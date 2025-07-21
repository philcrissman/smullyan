# frozen_string_literal: true

require_relative 'cardinal'
require_relative 'starling'
require_relative 'identity'

module Smullyan
  module Birds
    # The Warbler - duplicates its argument
    # Warbler x y = x y y

    # Derived implementation: W = C S I
    W_derived = C.(S).(I)

    # Direct implementation for comparison/efficiency
    W_direct = ->(x) { ->(y) { x.(y).(y) } }

    # Default to derived implementation
    Warbler = W_derived
    W = Warbler
  end
end
