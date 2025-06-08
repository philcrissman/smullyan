# frozen_string_literal: true

require_relative "starling"
require_relative "bluebird"
require_relative "kestrel"

module Smullyan
  module Birds
    # The Cardinal - flips the order of arguments
    # Cardinal x y z = x z y
    # Can be derived as: C = S (B B S) (K K)
    Cardinal = S.call(B.call(B).call(S)).call(K.call(K))
    
    # Direct implementation for comparison/efficiency
    Cardinal_direct = ->(x) { ->(y) { ->(z) { x.call(z).call(y) } } }
    
    # Traditional combinator name
    C = Cardinal         # C combinator
    C_direct = Cardinal_direct
  end
end