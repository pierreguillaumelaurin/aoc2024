# frozen_string_literal: true

# to access grid element: grid[1,1]
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

  def neighbors(position)
    limit_agnostic_neighbors(position)
      .reject { |r, c| r == row && c == col }
      .select do |r, c|
      r >= 0 && r < @data.length &&
        c >= 0 && c < @data[0].length
    end
  end

  def dimensions
    [@data.length, @data[0].length]
  end

  def [](row, col)
    @data[row][col]
  end

  private

  def limit_agnostic_neighbors(position)
    row, col = position
    (-1..1).flat_map do |dr|
      (-1..1).map do |dc|
        [row + dr, col + dc]
      end
    end
  end
end
