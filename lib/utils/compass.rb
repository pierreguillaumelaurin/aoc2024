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
    DIRECTIONS[direction]
  end

  def self.all_directions
    DIRECTIONS.keys
  end

  def self.cardinal_directions
    DIRECTIONS.slice(:east, :north, :west, :south).keys
  end

  def self.ordinal_directions
    DIRECTIONS.slice(:northeast, :northwest, :southeast, :southwest).keys
  end

  def self.opposite(input)
    direction = input.is_a?(Symbol) ? direction(input) : input
    [-direction[0], -direction[1]]
  end
end
