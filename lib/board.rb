# frozen_string_literal: true

class Board
  attr_reader :cells, :x, :y

  def initialize(x = 7, y = 6)
    @x = x
    @y = y
    create_cells(@x, @y)
    @cells = Cell.cells
  end

  def display
    cell_display_order = rearrange_cells(@cells)
    
    cell_display_order.size.times do |i|
      print "\n\t======================\n\t|" if i % x == 0
      cell_value = cell_display_order[i].value
      print cell_value.nil? ? " #{cell_value} |" : "#{cell_value} |"
    end
    print "\n\t======================\n\t"
    @x.times { |i| print " #{i + 1} " }
  
    puts "\n\n"
  end

  def rearrange_cells(cells)
    cells.sort_by { |cell| [cell.y, -(cell.x)] }.reverse
  end

  def create_cells(x = @x, y = @y)
    x.times do |i|
      y.times do |j|
        Cell.new(i, j)
      end
    end
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

  def game_over?
    winner? || full?
  end

  def winner?
    @cells.each do |cell|
      next if cell.value.nil?
      winner = direction_win?(cell, DIRECTIONS[:up]) || 
        direction_win?(cell, DIRECTIONS[:right]) || 
        direction_win?(cell, DIRECTIONS[:up_left]) || 
        direction_win?(cell, DIRECTIONS[:up_right])
      return winner if winner
    end
    false
  end

  DIRECTIONS = {
    up: { x:0, y:1 },
    right: { x:1, y:0 },
    up_left: { x:-1, y:1 },
    up_right: { x:1, y:1 }
  }

  def direction_win?(cell, direction)
    match_value = cell.value
    match_count = 1
    until match_count >= 4
      cell = Cell.find(cell.x + direction[:x], cell.y + direction[:y])
      return false if cell.nil?
      return false unless cell.value == match_value
      match_count += 1
    end
    true
  end

  def full?
    @cells.all? do |cell|
      cell.value
    end
  end
end


class Cell
  attr_reader :x, :y, :value

  @@cells = []

  def initialize(x, y)
    @x = x
    @y = y
    @value = nil
    #@value = "#{x},#{y}"
    @@cells << self
  end

  def self.find(x, y)
    @@cells.find { |cell| cell.x == x && cell.y == y }
  end

  def self.cells
    @@cells
  end

  def update_value(symbol)
    @value = symbol
  end
end