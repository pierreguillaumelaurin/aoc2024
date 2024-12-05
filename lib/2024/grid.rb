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
      .reject { |r, c| r == position[0] && c == position[1] }
      .select do |r, c|
      r >= 0 && r < @data.length &&
        c >= 0 && c < @data[0].length
    end
  end

  def line(start_pos, direction, length)
    row, col = start_pos
    dx, dy = direction

    (0...length).map do |step|
      new_row = row + step * dx
      new_col = col + step * dy

      # Check if the new position is within grid bounds
      return '' if new_row.negative? || new_row >= @data.length ||
                   new_col.negative? || new_col >= @data[0].length

      @data[new_row][new_col]
    end.join
  end

  def each_position
    (0...@data.length).each do |row|
      (0...@data[0].length).each do |col|
        yield [row, col]
      end
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
