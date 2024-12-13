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
    coordinates = Compass[direction]

    (0...length).map do |step|
      new_row = start_pos.x + step * coordinates.x
      new_col = start_pos.y + step * coordinates.y

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

  def search(value)
    each_position do |pos|
      return pos if self[pos] == value
    end

    nil
  end

  def swap(first_pos, second_pos)
    @data[first_pos.x][first_pos.y], @data[second_pos.x][second_pos.y] =
      @data[second_pos.x][second_pos.y], @data[first_pos.x][first_pos.y]
  end

  def each_position_in_inner_grid
    (1...@data.length - 1).each do |x|
      (1...@data[0].length - 1).each do |y|
        yield Coordinate.new(x, y)
      end
    end
  end

  def dimensions
    [@data.length, @data[0].length]
  end

  def within_bounds?(coordinate)
    coordinate.x >= 0 && coordinate.x < @data.length &&
      coordinate.y >= 0 && coordinate.y < @data[0].length
  end

  def [](coordinate)
    @data[coordinate.x][coordinate.y]
  end

  def []=(coordinate, value)
    @data[coordinate.x][coordinate.y] = value
  end

  def to_s
    @data.each do |row|
      pp row.map(&:to_s).join
    end
  end

  def inspect
    to_s
  end

  def deep_copy
    new_data = @data.map do |row|
      row.map(&:dup)
    rescue TypeError
      row.map(&:itself)
    end

    self.class.new(new_data)
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
