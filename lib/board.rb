# frozen_string_literal: true

class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def display
    binding.pry
    puts <<-BOARD
      
    BOARD
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

  def find_column(x)
    @cells.select { |cell| cell.x == x }
  end

  def find_lowest_cell(column)
    column.each do |cell| 
      return cell if cell.value.nil? 
    end
    return
  end
end

class Cell
  attr_reader :x, :y, :value

  def initialize(x, y)
    @x = x
    @y = y
    @value = nil
  end
end