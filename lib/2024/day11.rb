# frozen_string_literal: true

module Year2024
  module Day11
    class << self
      def part1(input)
        stones = input.body.chomp.split

        25.times do
          stones = blink(stones)
        end

        stones.count
      end

      def part2(input) end

      private

      def blink(stones)
        stones.flat_map do |stone|
          if stone.to_i.zero?
            '1'
          elsif stone.length.even?
            mid = stone.length / 2
            first = stone[0...mid]
            second = stone[mid..]

            [first, second.to_i.to_s]
          else
            stone.to_i.*(2024).to_s
          end
        end
      end
    end
  end
end
