require_relative 'coordinate'

module Compass
  DIRECTIONS = {
    east: Coordinate.new(0, 1),
    north: Coordinate.new(-1, 0),
    west: Coordinate.new(0, -1),
    south: Coordinate.new(1, 0),

    northeast: Coordinate.new(-1, 1),
    northwest: Coordinate.new(-1, -1),
    southeast: Coordinate.new(1, 1),
    southwest: Coordinate.new(1, -1)
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

  def self.opposite_coordinate(input)
    direction = input.is_a?(Symbol) ? self[input] : input
    raise ArgumentError, "Invalid direction: #{input}" unless direction.is_a?(Coordinate)

    Coordinate.new(-direction.x, -direction.y)
  end

  def self.clockwise(direction)
    clockwise = {
      north: :east,
      east: :south,
      south: :west,
      west: :north
    }

    clockwise[direction]
  end
end
