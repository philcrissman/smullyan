# frozen_string_literal: true

module Smullyan
  module Birds
    # The Kestrel - returns the first of two arguments
    # Kestrel x y = x
    Kestrel = ->(x) { ->(_y) { x } }

    # Traditional combinator name
    K = Kestrel # K combinator
  end
end
