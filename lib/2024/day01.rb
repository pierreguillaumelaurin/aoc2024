# frozen_string_literal: true

module Year2024
  module Day01
    class << self
      def part1(input)
        first = []
        second = []

        input.body.chomp.lines.each do |line|
          f, s = line.split('   ')
          first << f
          second << s
        end

        first.sort!
        second.sort!
        first.zip(second).sum { |f, s| (s.to_i - f.to_i).abs }
      end

      def part2
        puts 'works 2!'
      end
    end
  end
end
