# frozen_string_literal: true

module Smullyan
  module Birds
    # The Starling - distributes its third argument to both its first and second
    # Starling x y z = x z (y z)
    Starling = ->(x) { ->(y) { ->(z) { x.call(z).call(y.call(z)) } } }

    # Traditional combinator name
    S = Starling # S combinator
  end
end
