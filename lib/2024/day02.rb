# frozen_string_literal: true

module Year2024
  module Day02
    class << self
      def part1(input)
        reports = parse(input)
        reports.select(&method(:no_bad_levels?)).length
      end

      def part2(input)
        reports = parse(input)
        reports.select(&method(:tolerates_one_bad_level?)).length
      end

      private

      def no_bad_levels?(report)
        (report.each_cons(2).all? { |a, b| a < b } ||
      report.each_cons(2).all? { |a, b| a > b }) &&
          report.each_cons(2).all? { |a, b| (a - b).abs >= 1 && (a - b).abs <= 3 }
      end

      def tolerates_one_bad_level?(report)
        removals = (0...report.length).count do |index|
          test_report = report[0...index] + report[index + 1..]
          no_bad_levels?(test_report)
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
