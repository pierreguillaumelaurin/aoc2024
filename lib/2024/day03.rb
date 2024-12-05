# frozen_string_literal: true

require_relative 'grid'

module Year2024
  module Day03
    class << self
      def part1(input)
        grid = Grid.from_string(input.body.chomp)

        count = 0

        grid.each_position do |pos|
          if grid[*pos] == 'x'
            leading_to_xmas = grid.collect { |npos| grid.line(npos) }
            count += x_positions.collect { |x_pos| leads_to_xmas?(x_pos, dir, grid) }
          end
        end
      end

      def part2(input)
        cleaned = input.body.gsub(/don't\(\).*?do\(\)/m, 'do()')
        run cleaned
      end

      private

      def leads_to_xmas?(pos, dir, grid)
        case grid(pos)
        when 's'
          true
        when 'a'
          new_pos = grid.neighbors(pos).select { |neighbor_pos| grid(neighbor_pos) == 's' }
          leads_to_xmas?(new_pos, dir, grid)
        when 'm'
          new_pos = grid.neighbors(pos).select { |neighbor_pos| grid(neighbor_pos) == 'a' }
          leads_to_xmas?(new_pos, dir, grid)
        when 'x'
          new_pos = grid.neighbors(pos).select { |neighbor_pos| grid(neighbor_pos) == 'm' }
          leads_to_xmas?(new_pos, dir, grid)
        else
          false
        end
      end
    end
  end
end
