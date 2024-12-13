# frozen_string_literal: true

module Year2024
  module Day07
    class << self
      def part1(input)
        equations = parse(input)
        equations.select { |equation| possibly_true? equation }.sum(&:first)
      end

      def part2(input)
        equations = parse(input)
        equations.select { |equation| possibly_true_with_concatenation? equation }.sum(&:first)
      end

      private

      def parse(input)
        input.body.chomp.lines.collect { |line| line.scan(/\d+/).map(&:to_i) }
      end

      def possibly_true?(equation)
        result, *operands = equation
        first, *remaining = operands
        return result == first if operands.size == 1

        second, *rest = remaining

        possibly_true?([result, first * second, *rest]) ||
          possibly_true?([result, first + second, *rest])
      end

      def possibly_true_with_concatenation?(equation)
        result, *operands = equation
        first, *remaining = operands
        return result == first if operands.size == 1

        second, *rest = remaining

        possibly_true_with_concatenation?([result, first * second, *rest]) ||
          possibly_true_with_concatenation?([result, first + second, *rest]) ||
          possibly_true_with_concatenation?([result, "#{first}#{second}".to_i, *rest])
      end
    end
  end
end
