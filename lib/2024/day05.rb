# frozen_string_literal: true

require_relative '../utils/compass'
require_relative '../utils/grid'
require_relative '../utils/coordinate'

module Year2024
  module Day05
    class << self
      def part1(input)
        rules, updates = parse(input)

        override_integer_comparison(rules)

        updates.select { |u| u.sort == u }.collect { |u| u[u.length / 2] }.sum
      end

      def part2(input)
        rules, updates = parse(input)

        # not needed if part 1 is run before as it already overrides
        override_integer_comparison(rules)

        updates.reject { |u| u.sort == u }.collect(&:sort).collect { |u| u[u.length / 2] }.sum
      end

      private

      def parse(input)
        rules, updates = input.body.chomp.split("\n\n")

        rules = rules.lines.collect { |r| r.split('|').collect(&:to_i) }
        updates = updates.lines.collect { |r| r.split(',').collect(&:to_i) }

        [rules, updates]
      end

      def override_integer_comparison(rules)
        Integer.send(:define_method, :<=>) do |other|
          greater_than = {}

          rules.each do |rule|
            l, r = rule
            greater_than[l].nil? ? greater_than[l] = [r] : greater_than[l] << r
          end

          return -1 if greater_than[self].include? other

          return 1 if greater_than[other].include? self

          0
        end
      end
    end
  end
end
