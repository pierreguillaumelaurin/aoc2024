# frozen_string_literal: true

module Year2024
  module Day02
    class << self
      def part1(input)
        levels = parse(input)
        levels.select do |level|
          (level.each_cons(2).all? { |a, b| a < b } or
        level.each_cons(2).all? { |a, b| a > b }) and
            level.each_cons(2).all? { |a, b| (a - b).abs >= 1 && (a - b).abs <= 3 }
        end.length
      end

      def part2(input)
        first = []
        second = []

        input.body.chomp.lines.each do |line|
          f, s = line.split('   ')
          first << f.to_i
          second << s.to_i
        end

        first.sort!
        second.sort!

        answer = 0
        first.each do |n|
          answer += n * second.count(n)
        end

        answer
      end

      private

      def parse(input)
        lines = input.body.chomp.lines
        lines.collect { |line| line.split(' ').collect(&:to_i) }
      end
    end
  end
end
