# frozen_string_literal: true

require 'forwardable'
require_relative '../utils/grid'

module Year2024
  module Day12
    class << self
      def part1(input)
        garden = Garden.new(Grid.from_string(input.body.chomp))
        garden.fencing_price
      end

      def part2(input) end

      class Region
        def initialize(origin, garden)
          @origin = origin
          @garden = garden
          @area = 0
          @perimeter = 0
          @name = @garden[origin]

          dfs(origin)
        end

        def price
          @area * @perimeter
        end

        private

        def dfs(pos)
          return if @garden.seen.include? pos

          @garden.seen.add(pos)

          @area += 1
          foreign_neighbors = @garden.orthogonal_neighbors(pos).reject { |neighbor| @garden[neighbor] == @name }
          @perimeter += foreign_neighbors.count
          @perimeter += 1 if pos.x.zero? || pos.x == @garden.dimensions[0] - 1
          @perimeter += 1 if pos.y.zero? || pos.y == @garden.dimensions[1] - 1

          neighbors_to_visit = @garden.orthogonal_neighbors(pos)
                                      .reject { |p| @garden.seen.include?(p) }
                                      .select { |p| @garden[p] == @name }

          neighbors_to_visit.each do |neighbor_pos|
            dfs(neighbor_pos)
          end
        end
      end

      class Garden
        extend Forwardable
        def_delegators :@grid, :[], :orthogonal_neighbors, :dimensions
        attr_accessor :seen

        def initialize(grid)
          @grid = grid
          @regions = Hash.new(0)
          @seen = Set.new

          evaluate_price
        end

        def fencing_price
          @regions.values.sum
        end

        private

        def evaluate_price
          @grid.each_position do |pos|
            next if @seen.include? pos

            region = Region.new(pos, self)
            @regions[pos] = region.price
          end
        end
      end
    end
  end
end
