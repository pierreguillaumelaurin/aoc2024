# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'
require_relative '../utils/coordinate'

module Year2024
  module Day06
    class << self
      def part1(input)
        grid = Grid.from_string(input)
        position = grid.search('^')
        direction = :north
        count = 0

        while grid.within_bounds? position
          candidate = position + Compass[direction]

          if grid[candidate] == '#'
            direction = Compass.clockwise(direction)
          else
            grid.swap(position, candidate)
            position = candidate
            count += 1
          end
        end

        count
      end

      def part2(input) end
    end
  end
end
