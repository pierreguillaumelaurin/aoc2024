# frozen_string_literal: true

module Year2024
  module Day03
    class << self
      def part1(input)
        matches = input.body.scan(/mul\((\d{1,3}),(\d{1,3})\)/)

        matches.inject(0) do |sum, match|
          l, r = match
          sum + l.to_i * r.to_i
        end
      end

      def part2(input)
        true
      end
    end
  end
end
