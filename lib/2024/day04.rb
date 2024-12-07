# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'
require_relative '../utils/coordinate'

module Year2024
  module Day04
    class << self
      def part1(input)
        grid = Grid.from_string(input.body.chomp)
        count = 0

        grid.each_position do |pos|
          next unless grid[pos] == 'X'

          leading_to_xmas = Compass.all_directions.collect { |dir| grid.line(pos, dir, 4) }.select do |line|
            line == 'XMAS'
          end
          count += leading_to_xmas.count
        end

        count
      end

      def part2(input)
        grid = Grid.from_string(input.body.chomp)
        count = 0

        grid.each_position do |pos|
          next unless grid[*pos] == 'A'

          leading_to_xmas = Compass.ordinal_directions.collect { |dir| grid[] + grid[pos] + grid[pos] }.select do |line|
            line == 'MAS'
          end
          count += leading_to_xmas.count if leading_to_xmas.count == 2
        end

        count
      end
    end
  end
end
