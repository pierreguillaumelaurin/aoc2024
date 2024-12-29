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
        guard_path = guard_path(position, grid)

        guard_path.count
      end

      def part2(input)
        grid = Grid.from_string(input.body.chomp)
        position = grid.search('^')
        guard_path = guard_path(position, grid)

        guard_path.each.select { |obstacle_position| sabotages_patrol?(position, obstacle_position, grid) }.count
      end

      private

      def guard_path(position, grid)
        direction = :north
        seen = Set[position]

        while grid.within_bounds?(candidate = position + Compass[direction])
          if grid[candidate] == '#'
            direction = Compass.clockwise(direction)
          else
            grid.swap!(position, candidate)
            seen.add(candidate)
            position = candidate
          end
        end

        seen
      end

      def sabotages_patrol?(position, obstacle_position, grid)
        _grid = grid.deep_copy
        _grid[obstacle_position] = '#'
        raise 'Grids are equal' unless grid != _grid

        direction = :north
        seen = Set[]

        while _grid.within_bounds?(candidate = position + Compass[direction])
          if _grid[candidate] == '#'
            direction = Compass.clockwise(direction)

          elsif seen.include?([position, direction])
            return true
          else
            _grid.swap!(position, candidate)
            seen.add([position, direction])
            position = candidate
          end
        end

        false
      end
    end
  end
end
