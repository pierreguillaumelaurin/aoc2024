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
          @coordinates = Set.new
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
          total_sides = 0
          grid = Array.new(@garden.dimensions[0]) { Array.new(@garden.dimensions[1], false) }

          # Mark all coordinates in our region
          @coordinates.each do |pos|
            grid[pos.x][pos.y] = true
          end

          # Helper to check if a position is part of our region
          is_ours = lambda { |x, y|
            return false if x.negative? || y.negative? || x >= @garden.dimensions[0] || y >= @garden.dimensions[1]

            grid[x][y]
          }

          # Find horizontal sides
          (0...@garden.dimensions[0]).each do |x|
            current_side = false
            (0...@garden.dimensions[1]).each do |y|
              is_region = is_ours.call(x, y)
              above_diff = is_region != is_ours.call(x, y - 1)

              if above_diff
                if is_region
                  # Starting new side
                  current_side = true
                else
                  # Ending current side
                  total_sides += 1 if current_side
                  current_side = false
                end
              end
            end
            # End any remaining side
            total_sides += 1 if current_side
          end

          # Find vertical sides
          (0...@garden.dimensions[1]).each do |y|
            current_side = false
            (0...@garden.dimensions[0]).each do |x|
              is_region = is_ours.call(x, y)
              left_diff = is_region != is_ours.call(x - 1, y)

              if left_diff
                if is_region
                  # Starting new side
                  current_side = true
                else
                  # Ending current side
                  total_sides += 1 if current_side
                  current_side = false
                end
              end
            end
            # End any remaining side
            total_sides += 1 if current_side
          end

          total_sides
        end

        def dfs(pos)
          return if @garden.seen.include? pos

          @garden.seen.add(pos)

          @area += 1
          foreign_neighbors = @garden.orthogonal_neighbors(pos).reject { |neighbor| @garden[neighbor] == @name }
          @perimeter += foreign_neighbors.count
          @perimeter += 1 if pos.x.zero? || pos.x == @garden.dimensions[0] - 1
          @perimeter += 1 if pos.y.zero? || pos.y == @garden.dimensions[1] - 1

          @coordinates.add(pos)

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
