# frozen_string_literal: true

require_relative '../utils/coordinate'

module Year2024
  module Day13
    class << self
      def part1(input)
        groups = input.body.chomp.split("\n\n")

        groups.sum do |group|
          a, b, price = group.split("\n").collect { |line| Coordinate.from_array(line.scan(/\d+/).collect(&:to_i)) }
          minimal_token_final_position([a, b], price)
        end
      end

      def part2(input)
        groups = input.body.chomp.split("\n\n")

        groups.sum do |group|
          a, b, price = group.split("\n").collect { |line| Coordinate.from_array(line.scan(/\d+/).collect(&:to_i)) }
          price += Coordinate.new(10_000_000_000_000, 10_000_000_000_000)
          optimized_minimal_token_final_position([a, b], price)
        end
      end

      private

      def minimal_token_final_position(buttons, final_position)
        a, b = buttons
        min_score = Float::INFINITY
        101.times do |i|
          101.times do |j|
            crane_matches = (a.x * i + b.x * j == final_position.x) && (a.y * i + b.y * j == final_position.y)
            min_score = [3 * i + j, min_score].min if crane_matches
          end
        end
        return 0 if min_score == Float::INFINITY

        min_score
      end

      def optimized_minimal_token_final_position(buttons, final_position)
        a, b = buttons

        a_count = (b.y * final_position.x - b.x * final_position.y).to_f / (a.x * b.y - a.y * b.x)
        b_count = (final_position.y - a.y * a_count).to_f / b.y

        return 0 if a_count % 1 != 0 || b_count % 1 != 0 || a_count < 0 || b_count < 0

        (a_count * 3 + b_count).to_i
      end
    end
  end
end
