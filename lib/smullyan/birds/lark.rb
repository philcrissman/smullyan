# frozen_string_literal: true

require_relative 'cardinal'
require_relative 'bluebird'
require_relative 'mockingbird'

module Smullyan
  module Birds
    # The Lark - applies first argument to result of second argument applied to itself
    # Lark x y = x (y y)

    # Derived implementation: L = C B M
    L_derived = C.call(B).call(M)

    # Direct implementation for comparison/efficiency
    L_direct = ->(x) { ->(y) { x.call(y.call(y)) } }

    # Default to derived implementation
    Lark = L_derived
    L = Lark
  end
end
