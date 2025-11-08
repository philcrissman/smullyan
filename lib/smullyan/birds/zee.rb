# frozen_string_literal: true

require_relative 'starling'
require_relative 'kestrel'
require_relative 'bluebird'
require_relative 'cardinal'
require_relative 'queer'
require_relative 'turing'

module Smullyan
  module Birds
    # The Z combinator - applicative-order fixed-point combinator
    # Also known as the strict Y combinator, works in eager/strict evaluation languages
    # Z f = (λx.f (λv.x x v)) (λx.f (λv.x x v))

    # Direct implementation with explicit delays for strict evaluation
    Z_direct = ->(f) {
      ->(x) { f.(->(v) { x.(x).(v) }) }.(
        ->(x) { f.(->(v) { x.(x).(v) }) }
      )
    }

    # Theoretical derivations that work in lazy evaluation:
    # Z = S(KU)(SB(KQ))  - using S, K, B, Q, U combinators
    # Z = BU(CBQ)        - alternative formula using B, C, Q, U
    #
    # However, these don't work in Ruby's strict evaluation without explicit delays.
    # The derived formulas will cause infinite recursion in strict languages.
    # We include them here for reference but commented out:
    #
    # Z_from_SKI = S.(K.(U)).(S.(B).(K.(Q)))
    # Z_from_BCU = B.(U).(C.(B).(Q))

    # Default to direct implementation (required for strict evaluation)
    Z = Z_direct

    # Alternative names
    Zee = Z
  end
end
