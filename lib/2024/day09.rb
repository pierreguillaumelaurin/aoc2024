# frozen_string_literal: true

module Year2024
  module Day09
    class << self
      def part1(input)
        disk = Disk.new(input.body.chomp)
        disk.checksum
      end

      def part2(input)
        disk = Disk.new(input.body.chomp)
        disk.checksum_with_defragmentation
      end
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

      def compact_with_defragmentation
        file_blocks = {}
        free_blocks = []
        file_id = 0
        pos = 0
        @diskmap.chars.each_with_index do |slice, i|
          slice = slice.to_i
          if i.even?
            file_blocks[file_id] = [pos, slice]
            file_id += 1
          else
            free_blocks << [pos, slice] unless slice.zero?
          end
          pos += slice
        end

        while file_id.positive?
          file_id -= 1
          pos, size = file_blocks[file_id]
          free_blocks.each_with_index do |(start, length), i|
            if start >= pos
              free_blocks = free_blocks[0...i]
              break
            end
            next unless size <= length

            file_blocks[file_id] = [start, size]
            if size == length
              free_blocks.delete_at(i)
            else
              free_blocks[i] = [start + size, length - size]
            end
            break
          end
        end
        file_blocks
      end

      def checksum
        compact.each.with_index.sum do |id, i|
          id.to_i * i
        end
      end

      def checksum_with_defragmentation
        result = 0
        compact_with_defragmentation.each do |id, (pos, size)|
          (pos...pos + size).each do |current_pos|
            result += id * current_pos
          end
        end

        result
      end
    end
  end
end
