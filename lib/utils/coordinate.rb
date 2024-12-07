# frozen_string_literal: true

class Coordinate
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(other)
    case other
    when Coordinate
      Coordinate.new(@x + other.x, @y + other.y)
    when Array
      Coordinate.new(@x + other[0], @y + other[1])
    else
      raise ArgumentError, "Cannot add #{other.class} to Coordinate"
    end
  end

  def -(other)
    case other
    when Coordinate
      Coordinate.new(@x - other.x, @y - other.y)
    when Array
      Coordinate.new(@x - other[0], @y - other[1])
    else
      raise ArgumentError, "Cannot subtract #{other.class} from Coordinate"
    end
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  # Conversion to array
  def to_a
    [@x, @y]
  end

  # String representation
  def to_s
    "(#{x},#{y})"
  end

  # Inspect for debugging
  def inspect
    to_s
  end
end
