# frozen_string_literal: true

module Smullyan
  # Module for getting configurable combinator implementations
  module ConfigurableBirds
    class << self
      def B
        if Smullyan.configuration.direct?(:b)
          Birds::B_direct
        else
          Birds::B_derived
        end
      end
      alias Bluebird B

      def C
        if Smullyan.configuration.direct?(:c)
          Birds::C_direct
        else
          Birds::C_derived
        end
      end
      alias Cardinal C

      def W
        if Smullyan.configuration.direct?(:w)
          Birds::W_direct
        else
          Birds::W_derived
        end
      end
      alias Warbler W

      def M
        if Smullyan.configuration.direct?(:m)
          Birds::M_direct
        else
          Birds::M_derived
        end
      end
      alias Mockingbird M

      def L
        if Smullyan.configuration.direct?(:l)
          Birds::L_direct
        else
          Birds::L_derived
        end
      end
      alias Lark L
    end
  end
end