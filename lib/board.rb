# frozen_string_literal: true

class Board
  attr_reader :cells, :x, :y

  def initialize(x = 7, y = 6)
    @x = x
    @y = y
    @cells = create_cells(@x, @y)
  end

  def display
    cell_display_order = rearrange_cells(@cells)
    
    cell_display_order.size.times do |i|
      print "\n\t======================\n\t|" if i % x == 0
      cell_value = cell_display_order[i].value
      print " #{cell_value} |" if cell_value.nil?
      print "#{cell_value}|" if cell_value
    end
    print "\n\t======================\n\t"
    @x.times { |i| print " #{i + 1} " }
  
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

  def find_column_cell(number)
    target_column = find_column(number - 1)
    find_lowest_cell(target_column)
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

  def update_cells(cell, symbol)
    cell.update_value(symbol)
  end
end



class Cell
  attr_reader :x, :y, :value

  def initialize(x, y)
    @x = x
    @y = y
    @value = nil
    #@value = "#{x},#{y}"
  end

  def update_value(symbol)
    @value = symbol
  end
end