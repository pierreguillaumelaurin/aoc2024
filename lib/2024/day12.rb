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
          @border_coordinates = Set.new
          @name = @garden[origin]

          dfs(origin)
        end

        def price
          @area * @perimeter
        end

        def price_with_discount
          @area * sides
        end

        private

        def sides
          result = 0

          @border_coordinates.each do |pos|
            horizontal_neighbors = @border_coordinates.count { |other| other.x == pos.x && (other.y - pos.y).abs == 1 }
            vertical_neighbors = @border_coordinates.count { |other| other.y == pos.y && (other.x - pos.x).abs == 1 }

            result += 1 if horizontal_neighbors.zero? || vertical_neighbors.zero?
          end

          result
        end

        def dfs(pos)
          return if @garden.seen.include? pos

          @garden.seen.add(pos)

          @area += 1
          foreign_neighbors = @garden.orthogonal_neighbors(pos).reject { |neighbor| @garden[neighbor] == @name }
          @perimeter += foreign_neighbors.count
          @perimeter += 1 if pos.x.zero? || pos.x == @garden.dimensions[0] - 1
          @perimeter += 1 if pos.y.zero? || pos.y == @garden.dimensions[1] - 1

          @border_coordinates.add(pos) if foreign_neighbors.count.positive?

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
