# frozen_string_literal: true

require_relative '../utils/coordinate'
require_relative '../utils/compass'

module Year2024
  module Day14
    class << self
      WIDTH = 101
      HEIGHT = 103
      def part1(input)
        robots = input.body.chomp.lines.collect { |line| line.scan(/-?\d+/).collect(&:to_i) }

        robots = robots.collect do |px, py, vx, vy|
          [Coordinate.new(px, py), Coordinate.new(vx, vy)]
        end

        100.times do
          robots = tick(robots)
        end

        quadrants_safety_score(robots).reduce(:*)
      end

      def part2(input)
        robots = input.body.chomp.lines.collect { |line| line.scan(/-?\d+/).collect(&:to_i) }

        robots = robots.collect do |px, py, vx, vy|
          [Coordinate.new(px, py), Coordinate.new(vx, vy)]
        end

        min_safety_score = Float::INFINITY
        min_at = Float::INFINITY

        20_000.times do |i|
          candidate = quadrants_safety_score(robots).reduce(:*)
          if min_safety_score > candidate
            min_safety_score = candidate
            min_at = i
          end

          robots = tick(robots)
        end

        min_at
      end

      private

      def tick(robots)
        robots.collect do |pos, velocity|
          next_x = (pos.x + velocity.x) % WIDTH
          next_y = (pos.y + velocity.y) % HEIGHT
          next_x += WIDTH if next_x.negative?
          next_y += HEIGHT if next_y.negative?
          [Coordinate.new(next_x, next_y), velocity]
        end
      end

      def quadrants_safety_score(robots)
        horizontal_middle = WIDTH / 2
        vertical_middle = HEIGHT / 2

        northwest = robots.select { |pos, _| pos.x < horizontal_middle && pos.y < vertical_middle }.count
        northeast = robots.select { |pos, _| pos.x > horizontal_middle && pos.y < vertical_middle }.count
        southwest = robots.select { |pos, _| pos.x < horizontal_middle && pos.y > vertical_middle }.count
        southeast = robots.select { |pos, _| pos.x > horizontal_middle && pos.y > vertical_middle }.count

        [northwest, northeast, southwest, southeast]
      end

      def print(robots)
        grid = ''
        HEIGHT.times do |i|
          row = ''
          WIDTH.times do |j|
            row += robots[Coordinate.new(i, j)].nil? ? '-' : '*'
          end
          grid += row
          grid += "\n"
        end

        puts grid
      end
    end
  end
end
