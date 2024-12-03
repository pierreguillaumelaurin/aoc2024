# frozen_string_literal: true

module Year2024
  module Day02
    class << self
      def part1(input)
        levels = parse(input)
        levels.select(&method(:no_mistakes?)).length
      end

      def part2(input)
        levels = parse(input)
        levels.select(&method(:tolerates_one_bad_level?)).length
      end

      private

      def at_most_one_mistake?(level)
        no_mistakes?(level) || one_mistake?(level)
      end

      def no_mistakes?(level)
        (level.each_cons(2).all? { |a, b| a < b } ||
      level.each_cons(2).all? { |a, b| a > b }) &&
          level.each_cons(2).all? { |a, b| (a - b).abs >= 1 && (a - b).abs <= 3 }
      end

      def tolerates_one_bad_level?(level)
        removals = (0...level.length).count do |index|
          test_level = level[0...index] + level[index + 1..]
          no_mistakes?(test_level)
        end

        removals.positive?
      end

      def parse(input)
        lines = input.body.chomp.lines
        lines.collect { |line| line.split(' ').collect(&:to_i) }
      end
    end
  end
end
