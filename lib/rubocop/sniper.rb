require 'json'

require "rubocop/sniper/version"

module RuboCop
  module Sniper
    # Mokey-patch add_offense method
    module MonkeyPatchAddOffense
      def add_offense(node, loc, message = nil, severity = nil)
        location = find_location(node, loc)
        return unless Util.sniped?(location)

        super
      end
    end

    module Util
      def self.sniped?(location)
        positions = JSON.parse(ENV['RUBOCOP_SNIPER_POSITIONS'])
        positions.any? do |position|
          line, column = *position
          location.begin.line <= line &&
            line <= location.end.line &&
            location.begin.column <= column &&
            column <= location.end.column
        end
      end
    end

    Cop::Cop.__send__(:prepend, MonkeyPatchAddOffense)
  end
end
