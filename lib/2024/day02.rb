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
        levels.select do |level|
          (level.each_cons(2).all? { |a, b| a < b } or
        level.each_cons(2).all? { |a, b| a > b }) and
            level.each_cons(2).all? { |a, b| (a - b).abs >= 1 && (a - b).abs <= 3 }
        end.length
      end

      private

      def no_mistakes?(level)
        (level.each_cons(2).all? { |a, b| a < b } or
      level.each_cons(2).all? { |a, b| a > b }) and
          level.each_cons(2).all? { |a, b| (a - b).abs >= 1 && (a - b).abs <= 3 }
      end

      def parse(input)
        lines = input.body.chomp.lines
        lines.collect { |line| line.split(' ').collect(&:to_i) }
      end
    end
  end
end
