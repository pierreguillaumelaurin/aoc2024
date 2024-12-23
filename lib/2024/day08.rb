# frozen_string_literal: true

require_relative '../utils/grid'

module Year2024
  module Day08
    class << self
      def part1(input)
        grid = Grid.from_string(input.body.chomp)
        frequencies = {}
        antinodes = Set.new

        # census frequencies
        grid.each_position do |coord|
          cell = grid[coord]
          next if cell == '.'

          frequencies[cell] ||= []
          frequencies[cell] << coord
        end
        # census antinodes
        frequencies.each do |_freq, positions|
          positions.combination(2) do |pos1, pos2|
            grid.each_position do |candidate|
              dist1 = grid.euclidian(candidate, pos1)
              dist2 = grid.euclidian(candidate, pos2)

              area = (pos1.x * (pos2.y - candidate.y) +
                     pos2.x * (candidate.y - pos1.y) +
                     candidate.x * (pos1.y - pos2.y)).abs

              if area < 0.000001 && # collinear
                 ((dist1 * 2 - dist2).abs < 0.000001 || (dist2 * 2 - dist1).abs < 0.000001)
                antinodes.add(candidate)
              end
            end
          end
        end

        # result
        antinodes.count
      end

      def part2(input) end
    end
  end
end
