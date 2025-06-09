# frozen_string_literal: true

require_relative 'smullyan/version'
require_relative 'smullyan/configuration'
require_relative 'smullyan/birds/identity'
require_relative 'smullyan/birds/kestrel'
require_relative 'smullyan/birds/starling'
require_relative 'smullyan/birds/bluebird'
require_relative 'smullyan/birds/cardinal'
require_relative 'smullyan/birds/warbler'
require_relative 'smullyan/birds/mockingbird'
require_relative 'smullyan/birds/why'
require_relative 'smullyan/birds/lark'
require_relative 'smullyan/birds/finch'
require_relative 'smullyan/configurable_birds'

module Smullyan
  class Error < StandardError; end

  # All combinators are now in separate files
  module Birds
  end
end
