# frozen_string_literal: true

require_relative 'starling'
require_relative 'kestrel'

module Smullyan
  module Birds
    # The Identity bird - returns its argument unchanged
    # Identity x = x
    
    # I is SKK
    I_derived = S.(K).(K)

    I_direct = ->(x) { x }

    # Traditional combinator names
    Identity = I_derived     # I combinator
    I = Identity
    Idiot = Identity  # Alternative name from Smullyan's book
  end
end
