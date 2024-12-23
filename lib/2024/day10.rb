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

      def part2(input)
        grid = Grid.from_string(input.body.chomp)
        trailheads = grid.find_all('0').collect { |pos| Trailhead.new(pos, grid) }
        trailheads.sum(&:rating)
      end

      class Trailhead
        def initialize(pos, grid)
          @pos = pos
          @grid = grid
          @summits = Set.new
          @paths = Set.new

          census([pos])
        end

        def score
          @summits.count
        end

        def rating
          @paths.count
        end

        private

        def census(path)
          pos = path.last

          if @grid[pos] == '9'
            @summits.add(pos)
            @paths.add(path)
            return
          end

          options = @grid.orthogonal_neighbors(pos)
          options.each do |opt|
            census(path + [opt]) if @grid[opt].to_i - @grid[pos].to_i == 1
          end
        end
      end
    end
  end
end
