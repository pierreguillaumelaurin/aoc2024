# frozen_string_literal: true

module Year2024
  module Day09
    class << self
      def part1(input)
        disk = Disk.new(input.body.chomp)
        disk.checksum
      end

      def part2(input) end
    end

    class Disk
      def initialize(diskmap)
        @diskmap = diskmap.freeze
      end

      def uncompact
        result = []
        @diskmap.chars.each_slice(2).each_with_index do |slice, i|
          file = slice[0].to_i
          space = (slice[1] || '0').to_i

          file.times { result << i }

          space.times { result << '.' }
        end

        result
      end

      def compact
        result = uncompact
        left = 0
        right = result.rindex { |n| n.is_a? Integer }

        while left < right
          case [result[left], result[right]]
          when ->((first, second)) { first == '.' && second.is_a?(Integer) }
            result[left], result[right] = result[right], result[left]
            left += 1
            right -= 1
          when ->((first, second)) { first.is_a?(Integer) && second == '.' }
            left += 1
            right -= 1
          when ->((first, second)) { first == '.' && second == '.' }
            right -= 1
          when ->((first, second)) { first.is_a?(Integer) && second.is_a?(Integer) }
            left += 1
          else
            raise 'Uncovered case!'
          end
        end

        result
      end

      def checksum
        compact.each.with_index.sum do |id, i|
          id.to_i * i
        end
      end
    end
  end
end
