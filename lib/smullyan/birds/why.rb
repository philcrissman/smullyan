# frozen_string_literal: true

module Smullyan
  module Birds
    # The Why bird (Y combinator) - fixed-point combinator
    # Why f = f (Why f)
    # Here's a practical implementation that works in applicative-order languages like Ruby
    Why = lambda { |f|
      ->(x) { f.call(->(v) { x.call(x).call(v) }) }.call(
        ->(x) { f.call(->(v) { x.call(x).call(v) }) }
      )
    }

    # Alternative Z combinator (strict fixed-point) that's more suitable for eager evaluation
    Z = lambda { |f|
      ->(x) { f.call(->(v) { x.call(x).call(v) }) }.call(
        ->(x) { f.call(->(v) { x.call(x).call(v) }) }
      )
    }

    # Traditional combinator names
    Y = Why              # Y combinator (fixed-point)
    Sage = Why           # Y combinator (alternative name)
  end
end
