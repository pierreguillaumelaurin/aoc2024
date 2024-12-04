# frozen_string_literal: true

module Year2024
  module Day03
    class << self
      def part1(input)
        run input.body
      end

      def part2(input)
        cleaned = input.body.gsub(/don't\(\).*?do\(\)/m, 'do()')
        run cleaned
      end

      private

      def run(body)
        matches = body.scan(/mul\((\d{1,3}),(\d{1,3})\)/)

        matches.inject(0) do |sum, match|
          l, r = match
          sum + l.to_i * r.to_i
        end
      end
    end
  end
end
