# frozen_string_literal: true

module Smullyan
  module Birds
    # The Identity bird - returns its argument unchanged
    # Identity x = x
    Identity = ->(x) { x }
    
    # Traditional combinator names
    I = Identity      # I combinator
    Idiot = Identity  # Alternative name from Smullyan's book
  end
end