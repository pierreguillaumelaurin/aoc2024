# frozen_string_literal: true

require 'forwardable'
require_relative '../utils/compass'
require_relative '../utils/grid'

module Year2024
  module Day12
    class << self
      def part1(input)
        garden = Garden.new(Grid.from_string(input.body.chomp))
        garden.fencing_price
      end

      def part2(input)
        garden = Garden.new(Grid.from_string(input.body.chomp))
        garden.fencing_price_with_discount
      end

      class Region
        def initialize(origin, garden)
          @origin = origin
          @garden = garden
          @area = 0
          @perimeter = 0
          @corners = 0
          @coordinates = Set.new
          @name = @garden[origin]

          dfs(origin)
          find_corners
        end

        def price
          @area * @perimeter
        end

        def price_with_discount
          @area * @corners
        end

        private

        def find_corners
          corner_candidates = Set.new
          @coordinates.each do |coord|
            candidates = [
              Coordinate.new(coord.x - 0.5, coord.y - 0.5),
              Coordinate.new(coord.x + 0.5, coord.y - 0.5),
              Coordinate.new(coord.x + 0.5, coord.y + 0.5),
              Coordinate.new(coord.x - 0.5, coord.y + 0.5)
            ]
            candidates.each { |c| corner_candidates.add(c) }
          end

          corner_candidates.each do |coord|
            config = [
              Coordinate.new(coord.x - 0.5, coord.y - 0.5),
              Coordinate.new(coord.x + 0.5, coord.y - 0.5),
              Coordinate.new(coord.x + 0.5, coord.y + 0.5),
              Coordinate.new(coord.x - 0.5, coord.y + 0.5)
            ]

            overlaps = config.map do |overlap|
              @coordinates.include?(Coordinate.new(overlap.x.to_i, overlap.y.to_i))
            end

            total = overlaps.count(true)

            if total == 1
              @corners += 1
            elsif total == 2
              @corners += 2 if [[true, false, true, false], [false, true, false, true]].include?(overlaps)
            elsif total == 3
              @corners += 1
            end
          end
        end

        def dfs(pos)
          return if @garden.seen.include? pos

          @garden.seen.add(pos)
          @coordinates.add(pos)

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
          @regions.values.sum { |price, _| price }
        end

        def fencing_price_with_discount
          @regions.values.sum { |_, discounted_price| discounted_price }
        end

        private

        def evaluate_price
          @grid.each_position do |pos|
            next if @seen.include? pos

            region = Region.new(pos, self)
            @regions[pos] = [region.price, region.price_with_discount]
          end
        end
      end
    end
  end
end
