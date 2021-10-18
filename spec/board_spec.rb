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

  describe '#drop_piece' do
    # Script Method - Test inside methods
    
    describe '#find_column' do
      subject(:board_column) { described_class.new }
      context 'when given a y value' do
        it 'returns an Array of all Cells with that y value' do
          #Every item in column should have the instance variable @y value = y
          y = 0
          column = board_column.find_column(y)
          expect(column).to all(have_same_y_value(y))
        end
      end
    end
  
  end
  

end




