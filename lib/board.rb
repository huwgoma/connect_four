# frozen_string_literal: true

class Board
  attr_reader :cells, :x, :y

  def initialize(x = 6, y =7)
    @x = x
    @y = y
    @cells = create_cells(@x, @y)
  end

  def display
    cell_display_order = rearrange_cells(@cells)
    
    cell_display_order.size.times do |i|
      print "\n\t======================\n\t|" if i % y == 0
      print " #{cell_display_order[i].value} |"
    end
    print "\n\t======================\n\t"
    @y.times { |i| print " #{i + 1} " }
    puts "\n\n"
  end

  def rearrange_cells(cells)
    cells.sort_by { |cell| [cell.y, -(cell.x)] }.reverse
  end

  def create_cells(x = @x, y = @y, cells = [])
    x.times do |i|
      y.times do |j|
        cells << Cell.new(i, j)
      end
    end
    cells
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