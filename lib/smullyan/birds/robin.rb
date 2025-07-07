# frozen_string_literal: true

module Smullyan
  module Birds
    # The Robin - rotates arguments
    # Robin x y z = x z y

    # Direct implementation for comparison/efficiency
    R = ->(x) { -> (y) { -> (z) { y.(z).(x) }}}

    Robin = R
  end
end
