# frozen_string_literal: true

require_relative "cardinal"
require_relative "bluebird"
require_relative "mockingbird"

module Smullyan
  module Birds
    # The Lark - applies first argument to result of second argument applied to itself
    # Lark x y = x (y y)
    # Can be derived as: L = C B M
    Lark = C.call(B).call(M)
    
    # Direct implementation for comparison/efficiency
    Lark_direct = ->(x) { ->(y) { x.call(y.call(y)) } }
    
    # Traditional combinator name
    L = Lark         # L combinator
    L_direct = Lark_direct
  end
end