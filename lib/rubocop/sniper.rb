require 'json'

require "rubocop/sniper/version"

module RuboCop
  module Sniper
    module MonkeyPatchAddOffense
      def add_offense(node, loc, message = nil, severity = nil)
        location = find_location(node, loc)
        return unless Util.sniped?(location)

        super
      end
    end

    module Util
      def self.sniped?(location)
        # [
        #   {
        #     file: "path/to/file.rb",
        #     line: [1, 2],
        #     column: [3, 4]
        #   }
        # ]
        positions = JSON.parse(ENV['RUBOCOP_SNIPER_POSITIONS'], symbolize_names: true)
        positions.each do |position|
          first, last = *position[:line]
          position[:line] = first..last
          first, last = *position[:column]
          position[:column] = first..last
        end

        positions.any? do |position|
          # TODO: check filename

          overlap?(position[:line], location.begin.line..location.end.line) &&
            overlap?(position[:column], location.begin.column..location.end.column)
        end
      end

      private_class_method

      def self.overlap?(range1, range2)
        range2.first <= range1.last && range1.first <= range2.last
      end
    end

    Cop::Cop.__send__(:prepend, MonkeyPatchAddOffense)
  end
end
