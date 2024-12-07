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

        grid.each_position_in_inner_grid do |pos|
          next unless grid[pos] == 'A'

          leading_to_xmas = crosswords(pos, grid).select do |line|
            line == 'MAS'
          end

          count += 1 if leading_to_xmas.count == 2
        end

        count
      end

      private

      def crosswords(pos, grid)
        Compass.ordinal_directions.collect do |dir|
          direction_coordinate = Compass[dir]
          grid[pos - direction_coordinate] + grid[pos] + grid[pos + direction_coordinate]
        end
      end
    end
  end
end
