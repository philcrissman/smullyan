module Smullyan
    module Birds
        # The Finch bird (F combinator)
        # The finch applies its third argument 
        # to the first and second arguments in reverse order.
        # Finch x y z = z y x
        Finch = ->(x) { ->(y) { ->(z) { z.call(y).call(x) } } }

        # Traditional combinator name
        F = Finch # F combinator
    end
end