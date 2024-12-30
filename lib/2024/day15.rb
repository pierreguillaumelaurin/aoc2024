# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'

module Year2024
  module Day15
    class << self
      class Warehouse
        attr_reader :grid

        EMPTY = '.'
        BOXES = ['O', '[', ']'].freeze
        ROBOT = '@'
        WALL = '#'

        def initialize(grid)
          @grid = grid
          @robot = @grid.find(ROBOT)
        end

        def move_robot!(moves)
          moves.each do |dir|
            move!(@robot, dir) if valid?(@robot, dir)
          end
        end

        def coordinates_sum
          total = 0
          @grid.each_position do |pos|
            total += 100 * pos.x + pos.y if BOXES.include?(@grid[pos])
          end
          total
        end

        def coordinates_sum_when_wider
          total = 0
          @grid.each_position do |pos|
            total += 100 * pos.x + pos.y if @grid[pos] == '['
          end
          total
        end

        def widen!
          widened_data = @grid.data.collect do |row|
            row.flat_map { |cell| widened_tile(cell) }
          end

          @grid = Grid.new(widened_data)
        end

        private

        def move!(pos, dir)
          candidate = pos + Compass[dir]

          raise "invalid move attempt on position #{pos} with direction #{dir}" if @grid[candidate] == WALL

          if @grid[candidate] == EMPTY
            @robot = candidate if @grid[pos] == ROBOT
            return @grid.swap!(candidate, pos)
          end

          if @grid[candidate] == '[' && ['^', 'v'].include?(dir)
            other_box_half = candidate + Compass[:east]
            move!(candidate, dir) && move!(other_box_half, dir)
          elsif @grid[candidate] == ']' && ['^', 'v'].include?(dir)
            other_box_half = candidate + Compass[:west]
            move!(candidate, dir) && move!(other_box_half, dir)
          else
            move!(candidate, dir)
          end

          @robot = candidate if @grid[pos] == ROBOT
          @grid.swap!(candidate, pos)
        end

        def valid?(pos, dir)
          candidate = pos + Compass[dir]

          return true if @grid[candidate] == EMPTY
          return false if @grid[candidate] == WALL

          p @grid[candidate] if @grid[candidate] == '[' || @grid[candidate] == ']'
          if @grid[candidate] == '[' && ['^', 'v'].include?(dir)
            other_box_half = candidate + Compass[:east]
            valid?(candidate, dir) && valid?(other_box_half, dir)
          elsif @grid[candidate] == ']' && ['^', 'v'].include?(dir)
            other_box_half = candidate + Compass[:west]
            valid?(candidate, dir) && valid?(other_box_half, dir)
          else
            valid?(candidate, dir)
          end
        end

        def widened_tile(value)
          case value
          when WALL
            [WALL, WALL]
          when 'O'
            ['[', ']']
          when EMPTY
            [EMPTY, EMPTY]
          when ROBOT
            [ROBOT, EMPTY]
          else
            raise "unknown title! #{value}"
          end
        end
      end

      def part1(input)
        grid, moves = input.body.chomp.split("\n\n")

        warehouse = Warehouse.new(Grid.from_string(grid))
        warehouse.move_robot!(moves.gsub("\n", '').split(''))

        warehouse.coordinates_sum
      end

      def part2(input)
        grid, moves = input.body.chomp.split("\n\n")

        warehouse = Warehouse.new(Grid.from_string(grid))
        warehouse.widen!
        p warehouse.grid
        warehouse.move_robot!(moves.gsub("\n", '').split(''))

        warehouse.coordinates_sum_when_wider
      end
    end
  end
end
