# frozen_string_literal: true

class Coordinate
  include Comparable
  attr_reader :x, :y

  def self.from_array(array)
    raise ArgumentError, 'Array must have exactly 2 elements' unless array.size == 2

    new(array[0], array[1])
  end

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

  def *(other)
    case other
    when Coordinate
      Coordinate.new(@x * other.x, @y * other.y)
    when Array
      Coordinate.new(@x * other[0], @y * other[1])
    else
      raise ArgumentError, "Cannot multiply #{other.class} from Coordinate"
    end
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def <=>(other)
    x_comp = @x <=> other.x
    return x_comp unless x_comp.zero?

    @y <=> other.y
  end

  def eql?(other)
    self == other
  end

  def hash
    [@x, @y].hash
  end

  def to_a
    [@x, @y]
  end

  def to_s
    "(#{x},#{y})"
  end

  def inspect
    to_s
  end
end
