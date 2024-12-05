# frozen-string-literal: true

module Compass
  EAST  = [0, 1]
  NORTH = [-1, 0]
  WEST  = [0, -1]
  SOUTH = [1, 0]

  def self.direction(sym)
    const_get(sym.upcase)
  end
end
