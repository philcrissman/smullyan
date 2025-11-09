# frozen_string_literal: true

module Smullyan
  module Birds
    # The Turing bird - duplicating combinator
    # Turing x y = y (x x y)

    # Direct implementation
    U_direct = ->(x) { ->(y) { y.(x.(x).(y)) } }

    # Default to direct implementation
    Turing = U_direct
    U = Turing
  end
end
