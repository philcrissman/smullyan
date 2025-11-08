# frozen_string_literal: true

module Smullyan
  module Birds
    # The Z combinator - applicative-order fixed-point combinator
    # Also known as the strict Y combinator, works in eager/strict evaluation languages
    # Z f = (λx.f (λv.x x v)) (λx.f (λv.x x v))
    Z = ->(f) {
      ->(x) { f.(->(v) { x.(x).(v) }) }.(
        ->(x) { f.(->(v) { x.(x).(v) }) }
      )
    }

    # Alternative names
    Zee = Z
  end
end
