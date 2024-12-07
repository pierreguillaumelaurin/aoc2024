# frozen-string-literal: true

module Compass
  DIRECTIONS = {
    east: [0, 1],
    north: [-1, 0],
    west: [0, -1],
    south: [1, 0],

    northeast: [-1, 1],
    northwest: [-1, -1],
    southeast: [1, 1],
    southwest: [1, -1]
  }

  def self.[](direction)
    DIRECTIONS[direction.downcase.to_sym]
  end

  def self.all_directions
    DIRECTIONS.keys
  end

  def self.cardinal_directions
    DIRECTIONS.slice(:east, :north, :west, :south).values
  end

  def self.ordinal_directions
    DIRECTIONS.slice(:northeast, :northwest, :southeast, :southwest).values
  end
end
