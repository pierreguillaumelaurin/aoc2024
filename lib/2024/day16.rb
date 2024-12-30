# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'

module Year2024
  module Day16
    class << self
      class Maze
        def initialize(grid)
          @grid = grid
          @start = grid.find('S')
          @end = grid.find('E')
          @dir = { @start => :east }
        end

        def lowest_score
          spfa
        end

        private

        def spfa
          queue = [@start]
          score = Hash.new(Float::INFINITY)
          score[@start] = 0

          while queue.count.positive?
            node = queue.shift
            candidates = @grid.orthogonal_neighbors(node).reject { |neighbor| @grid[neighbor] == '#' }
            candidates.each do |candidate|
              weight, dir = get_weight(node, candidate)
              next if score[candidate] <= score[node] + weight

              @dir[candidate] = dir
              queue << candidate
              score[candidate] = score[node] + weight
            end
          end
          score[@end]
        end

        def get_weight(source, destination)
          shift_cost = 1
          dir = @dir[source]

          until source + Compass[dir] == destination
            dir = Compass.clockwise(dir)
            shift_cost += 1000
          end

          return [1001, dir] if shift_cost == 3001

          [shift_cost, dir]
        end
      end

      def part1(input)
        maze = Maze.new(Grid.from_string(input.body.chomp))

        maze.lowest_score
      end

      def part2(input) end
    end
  end
end
