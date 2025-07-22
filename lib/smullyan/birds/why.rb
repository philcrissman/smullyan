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

    # This is supposedly the correct derivation, but it winds up
    # as an infinite loop if we use it. :/ :? 
    # TODO look into this later!
    # S(K(SII))(S(S(KS)K)(K(SII)))
    Y_derived = S.(K.(S.(I).(I))).(S.(S.(K.(S)).(K)).(K.(S.(I).(I))))

    # Traditional combinator names
    Why = Y_direct
    Y = Why              # Y combinator (fixed-point)
    Sage = Why           # Y combinator (alternative name)
  end
end
