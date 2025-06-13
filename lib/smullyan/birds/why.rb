# frozen_string_literal: true

module Smullyan
  module Birds
    # The Why bird (Y combinator) - fixed-point combinator
    # Why f = f (Why f)
    Why = lambda { |f|
      ->(x) { f.call(->(v) { x.call(x).call(v) }) }.call(
        ->(x) { f.call(->(v) { x.call(x).call(v) }) }
      )
    }

    # Traditional combinator names
    Y = Why              # Y combinator (fixed-point)
    Sage = Why           # Y combinator (alternative name)
  end
end
