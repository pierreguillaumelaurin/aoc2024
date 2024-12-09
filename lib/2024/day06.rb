# frozen_string_literal: true

require 'set'

require_relative '../utils/compass'
require_relative '../utils/grid'
require_relative '../utils/coordinate'

module Year2024
  module Day06
    class << self
      def part1(input)
        grid = Grid.from_string(input.body.chomp)
        position = grid.search('^')
        direction = :north
        seen = Set[position]

        while grid.within_bounds?(candidate = position + Compass[direction])
          if grid[candidate] == '#'
            direction = Compass.clockwise(direction)
          else
            grid.swap(position, candidate)
            seen.add(candidate)
            position = candidate
          end
        end

        seen.count
      end

      def part2(input) end
    end
  end
end
