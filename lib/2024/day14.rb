# frozen_string_literal: true

require_relative '../utils/coordinate'

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

      def part2(input) end

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
    end
  end
end
