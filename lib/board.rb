# frozen_string_literal: true

class Board
  def initialize
    @cells = create_cells
  end

  def create_cells(x = 6, y = 7, cells = [])
    x.times do |i|
      y.times do |j|
        cells << Cell.new(i, j)
      end
    end
    cells
  end

  def drop_piece(y, symbol)

  end

  def find_column(y)
    @cells.select { |cell| cell.y == y }
  end
end

class Cell
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @value = nil
  end
end