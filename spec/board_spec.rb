# frozen_string_literal: true
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    # Initialize - Do not need to test, but test inside methods
  end

  describe '#create_cells' do
    # Returns a 2-dimensional array of cells representing the columns and rows of the board

    context 'for a 6x7 grid' do
      it 'sends a message to Cell 42 times to create 42 cells' do
        x = 6
        y = 7
        expect(Cell).to receive(:new).exactly(6*7).times
        Board.new
      end

      it 'returns an array of 4 Cell objects' do
        cells = Board.new.create_cells
        expect(cells).to be_an(Array)
        expect(cells).to all(be_a(Cell))
      end
    end
  end

  describe '#find_column' do
    subject(:board_column) { described_class.new }
    context 'when given an x value' do
      it 'returns an Array of all Cells with that x value' do
        #Every item in column should have the instance variable @x value = x
        x = 0
        column = board_column.find_column(x)
        expect(column).to all(have_same_x_value(x))
      end
    end
  end

  describe '#find_lowest_cell' do
    subject(:board_lowest) { described_class.new }
    context 'when given a column of Cells (array)' do
      before do
        @cell_one = instance_double(Cell, x:0, y:0, value:'⚫')
        @cell_two = instance_double(Cell, x:0, y:1, value:'⚫')
        @cell_three = instance_double(Cell, x:0, y:2, value:nil) 
      end

      it 'returns the lowest empty Cell in the array' do
        # The Cell with the lowest y-value that has @value: nil
        column = [@cell_one, @cell_two, @cell_three]
        expect(board_lowest.find_lowest_cell(column)).to eq(@cell_three)
      end
    end

    context 'when none of the Cells in the column are empty' do
      before do
        @cell_one = instance_double(Cell, x:0, y:0, value:'⚪')
        @cell_two = instance_double(Cell, x:0, y:1, value:'⚫')
        @cell_three = instance_double(Cell, x:0, y:2, value:'⚫') 
      end

      it 'returns nil' do
        column = [@cell_one, @cell_two, @cell_three]
        expect(board_lowest.find_lowest_cell(column)).to be_nil
      end
    end
  
  end
  

end




