# frozen_string_literal: true

module Year2024
  module Day11
    class << self
      def part1(input)
        stones = input.body.chomp.split.map { |stone| [stone, 1] }.to_h

        25.times do
          stones = blink(stones)
        end

        stones.values.sum
      end

      def part2(input)
        stones = input.body.chomp.split.map { |stone| [stone, 1] }.to_h

        75.times do
          stones = blink(stones)
        end

        stones.values.sum
      end

      private

      def blink(stones)
        next_stones = Hash.new(0)
        stones.each do |stone, n|
          if stone.to_i.zero?
            next_stones['1'] += 1 * n
          elsif stone.length.even?
            mid = stone.length / 2
            first = stone[0...mid]
            second = stone[mid..].to_i.to_s

            next_stones[first] += n
            next_stones[second] += n
          else
            next_stones[stone.to_i.*(2024).to_s] += n
          end
        end
        next_stones
      end
    end
  end
end
