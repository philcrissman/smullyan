# frozen_string_literal: true

require_relative "starling"
require_relative "kestrel"

module Smullyan
  module Birds
    # The Bluebird - function composition
    # Bluebird x y z = x (y z)
    # Can be derived as: B = S (K S) K
    Bluebird = S.call(K.call(S)).call(K)
    
    # Direct implementation for comparison/efficiency
    Bluebird_direct = ->(x) { ->(y) { ->(z) { x.call(y.call(z)) } } }
    
    # Traditional combinator name
    B = Bluebird         # B combinator
    B_direct = Bluebird_direct
  end
end