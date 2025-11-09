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

    # Theoretical derivations from literature:
    # Wikipedia and other sources cite: Z = S(KU)(SB(KQ)) or Z = BU(CBQ)
    #
    # INVESTIGATION RESULT: These formulas DO NOT WORK in Ruby when Q is the Queer bird.
    #
    # Through lambda calculus reduction (see ../../../Z_COMBINATOR_FINDINGS.md), we proved:
    #   Z = BU(CBQ) reduces to: Z f y = y (f (λz. y (f (Q z))))
    #
    # This tries to call y as a function, but when using Z for recursion (e.g., factorial),
    # y is a NUMBER, not a function. This causes: TypeError: Proc can't be coerced into Integer
    #
    # Conclusion: Either the formula uses a different combinator also named "Q",
    # or the formula only works in lazy evaluation despite Z being for strict evaluation.
    #
    # We include attempted implementations here for reference:
    # Z_from_SKI = S.(K.(U)).(S.(B).(K.(Q)))  # DOES NOT WORK
    # Z_from_BCU = B.(U).(C.(B).(Q))          # DOES NOT WORK

    # Default to direct implementation (the only one that works)
    Z = Z_direct

    # Alternative names
    Zee = Z
  end
end
