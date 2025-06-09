# frozen_string_literal: true

require_relative 'starling'
require_relative 'kestrel'

module Smullyan
  module Birds
    # The Bluebird - function composition
    # Bluebird x y z = x (y z)

    # Derived implementation: B = S (K S) K
    B_derived = S.call(K.call(S)).call(K)

    # Direct implementation for comparison/efficiency
    B_direct = ->(x) { ->(y) { ->(z) { x.call(y.call(z)) } } }

    # Default to derived implementation for backward compatibility
    Bluebird = B_derived
    B = Bluebird
  end
end
