# frozen_string_literal: true

module Smullyan
  module Birds
    # The Queer bird - forward composition
    # Queer x y z = y (x z)

    # Direct implementation
    Q_direct = ->(x) { ->(y) { ->(z) { y.(x.(z)) } } }

    # Default to direct implementation
    Queer = Q_direct
    Q = Queer
  end
end
