# frozen_string_literal: true

module Year2024
  module Day01
    class << self
      def part1(input)
        first = []
        second = []

        input.body.chomp.lines.each do |line|
          f, s = line.split('   ')
          first << f.to_i
          second << s.to_i
        end

        first.sort!
        second.sort!
        first.zip(second).sum { |f, s| (s - f).abs }
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
    end
  end
end
