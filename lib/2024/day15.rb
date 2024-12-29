# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'

module Year2024
  module Day15
    class << self
      class Warehouse
        EMPTY = '.'
        BOX = 'O'
        ROBOT = '@'
        WALL = '#'

        def initialize(grid)
          @grid = grid
        end

        def move_robot!(moves)
          moves.each do |dir|
            pos = @grid.find(ROBOT)
            move!(pos, dir) if valid?(pos, dir)
          end
        end

        def coordinates_sum
          total = 0
          @grid.each_position do |pos|
            total += 100 * pos.x + pos.y if @grid[pos] == 'O'
          end
          total
        end

        private

        def move!(pos, dir)
          candidate = pos + Compass[dir]

          raise "invalid move attempt on position #{pos} with direction #{dir}" if @grid[candidate] == WALL
          return @grid.swap!(candidate, pos) if @grid[candidate] == EMPTY

          move!(candidate, dir)
          @grid.swap!(candidate, pos)
        end

        def valid?(pos, dir)
          candidate = pos + Compass[dir]

          return true if @grid[candidate] == EMPTY
          return false if @grid[candidate] == WALL

          valid?(candidate, dir)
        end
      end

      def part1(input)
        grid, moves = input.body.chomp.split("\n\n")

        warehouse = Warehouse.new(Grid.from_string(grid))
        warehouse.move_robot!(moves.gsub("\n", '').split(''))

        warehouse.coordinates_sum
      end

      def part2(input) end
    end
  end
end
