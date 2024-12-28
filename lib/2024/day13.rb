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
          price *= Coordinate.new(10_000_000_000_000, 10_000_000_000_000)
          # find
        end
      end

      private

      def minimal_token_final_position(buttons, final_position)
        cache = Hash.new(Float::INFINITY)
        cache[Coordinate.new(0, 0)] = 0

        queue = [[Coordinate.new(0, 0), 0]]

        until queue.empty?
          position, current_tokens = queue.shift

          return current_tokens if position == final_position
          break if position.x > final_position.x || position.y > final_position.y

          a, b = buttons
          next_moves = [
            [position + a, 3],
            [position + b, 1],
            [position + a + b, 4]
          ]

          next_moves.each do |next_pos, cost|
            next if next_pos.x > final_position.x || next_pos.y > final_position.y

            total_tokens = current_tokens + cost
            if total_tokens < cache[next_pos]
              cache[next_pos] = total_tokens
              queue << [next_pos, total_tokens]
            end
          end
        end

        return 0 if cache[final_position].infinite?

        cache[final_position]
      end
    end
  end
end
