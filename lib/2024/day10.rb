# frozen_string_literal: true

require_relative '../utils/grid'

module Year2024
  module Day10
    class << self
      def part1(input)
        grid = Grid.from_string(input.body.chomp)
        trailheads = grid.find_all('0').collect { |pos| Trailhead.new(pos, grid) }
        trailheads.sum(&:score)
      end

      def part2(input) end

      class Trailhead
        def initialize(pos, grid)
          @pos = pos
          @grid = grid
          @summits = Set.new

          dfs([pos])
        end

        def score
          @summits.count
        end

        private

        def dfs(path)
          pos = path.last

          if @grid[pos] == '9'
            @summits.add(pos)
            return
          end

          options = @grid.orthogonal_neighbors(pos)
          options.each do |opt|
            dfs(path + [opt]) if @grid[opt].to_i - @grid[pos].to_i == 1
          end
        end
      end
    end
  end
end
