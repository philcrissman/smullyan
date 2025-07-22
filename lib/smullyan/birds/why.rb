# frozen_string_literal: true

module Smullyan
  module Birds
    # The Why bird (Y combinator) - fixed-point combinator
      # Why f = f (Why f)
      Y_direct = -> (f) {
      ->(x) { f.(->(v) { x.(x).(v) }) }.(
        ->(x) { f.(->(v) { x.(x).(v) }) }
      )
    }

    # Traditional combinator names
    Why = Y_direct
    Y = Why              # Y combinator (fixed-point)
    Sage = Why           # Y combinator (alternative name)
  end
end
