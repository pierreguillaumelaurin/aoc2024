# frozen_string_literal: true

require_relative 'compass'
require_relative 'coordinate'

class Grid
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.from_string(str, converter = :itself)
    data = str.split("\n").map do |row|
      row.chars.map(&converter)
    end
    new(data)
  end

  def neighbors(coordinate)
    limit_agnostic_neighbors(coordinate)
      .reject { |neighbor| neighbor.x == position.x && neighbor.y == position.y }
      .select do |neighbor|
      neighbor.x >= 0 && neighbor.x < @data.length &&
        neighbor.y >= 0 && neighbor.y < @data[0].length
    end
  end

  def line(start_pos, direction, length)
    dx, dy = Compass[direction]

    (0...length).map do |step|
      new_row = start_pos.x + step * dx
      new_col = start_pos.y + step * dy

      # Check if the new position is within grid bounds
      return '' if new_row.negative? || new_row >= @data.length ||
                   new_col.negative? || new_col >= @data[0].length

      @data[new_row][new_col]
    end.join
  end

  def each_position
    (0...@data.length).each do |x|
      (0...@data[0].length).each do |y|
        yield Coordinate.new(x, y)
      end
    end
  end

  def dimensions
    [@data.length, @data[0].length]
  end

  def [](coordinate)
    @data[coordinate.x][coordinate.y]
  end

  private

  def limit_agnostic_neighbors(coordinate)
    (-1..1).flat_map do |dr|
      (-1..1).map do |dc|
        [coordinate.x + dr, coordinate.y + dc]
      end
    end
  end
end
