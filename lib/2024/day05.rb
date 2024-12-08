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

        updates.select { |u| u.sort == u }.count
      end

      def part2(input) end

      private

      def parse(input)
        rules, updates = input.body.chomp.split("\n\n")

        rules = rules.lines.collect { |r| r.split('|').collect(&:to_i) }
        updates = updates.lines.collect { |r| r.split(',').collect(&:to_i) }

        [rules, updates]
      end

      def override_integer_comparison(rules)
        Integer.send(:define_method, :<=>) do |other|
          greather_than = {}

          rules.each do |rule|
            l, r = rule
            greather_than[l].nil? ? greather_than[l] = [r] : greather_than[l] << r
          end

          p greather_than

          return -1 if greather_than[self].include? other

          return 1 if greather_than[other].include? self

          0
        end
      end
    end
  end
end
