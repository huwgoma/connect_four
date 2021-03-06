# frozen_string_literal: true
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require 'pry'

describe Board do
  before do
    @cells = []
    4.times do |i|
      4.times do |j|
        @cells << instance_double(Cell, "#{i}, #{j}", x:i, y:j, value:nil)
        # [[0, 0], [0, 1], [0, 2], [0, 3] - Column 1
        #  [1, 0], [1, 1], [1, 2], [1, 3] - Column 2
        #  [2, 0], [2, 1], [2, 2], [2, 3] - Column 3
        #  [3, 0], [3, 1], [3, 2], [3, 3] - Column 4
      end
    end
  end

  describe '#initialize' do
    # Initialize - Do not need to test, but test inside methods
  end

  describe '#create_cells' do
    # Returns a 2-dimensional array of cells representing the columns and rows of the board

    context 'for a 6x7 grid' do
      before do
        @x = 7
        @y = 6
      end

      it 'sends a message to Cell 42 times to create 42 cells' do
        expect(Cell).to receive(:new).exactly(@x*@y).times
        Board.new
      end
    end
  end

  describe '#rearrange_cells' do
    subject(:board_rearrange) { described_class.new }
    context 'given an Array of Cells sorted bottom-up, left-right' do
      # [[0, 0], [0, 1], [0, 2], [0, 3] - Column 1
      #  [1, 0], [1, 1], [1, 2], [1, 3] - Column 2
      #  [2, 0], [2, 1], [2, 2], [2, 3] - Column 3
      #  [3, 0], [3, 1], [3, 2], [3, 3] - Column 4
      it 'returns an Array sorted left-right, top-down' do
        # [[0, 3], [1, 3], [2, 3], [3, 3]
        #  [0, 2], [1, 2], [2, 2], [3, 2]
        #  [0, 1], [1, 1], [2, 1], [3, 1]
        #  [0, 0], [1, 0], [2, 0], [3, 0]]
        cells_after = [
          @cells[3], @cells[7], @cells[11], @cells[15],
          @cells[2], @cells[6], @cells[10], @cells[14],
          @cells[1], @cells[5], @cells[9], @cells[13],
          @cells[0], @cells[4], @cells[8], @cells[12]]

        expect(board_rearrange.rearrange_cells(@cells)).to eq(cells_after)
      end
    end
  end

  describe '#find_column_cell' do
    # Script Method - Test all inside methods
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
        @cell_one = instance_double(Cell, x:0, y:0, value:'???')
        @cell_two = instance_double(Cell, x:0, y:1, value:'???')
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
        @cell_one = instance_double(Cell, x:0, y:0, value:'???')
        @cell_two = instance_double(Cell, x:0, y:1, value:'???')
        @cell_three = instance_double(Cell, x:0, y:2, value:'???') 
      end

      it 'returns nil' do
        column = [@cell_one, @cell_two, @cell_three]
        expect(board_lowest.find_lowest_cell(column)).to be_nil
      end
    end
  end
  
  describe '#update_cells' do
    subject(:board_update) { described_class.new }
    let(:target_cell) { instance_double(Cell, x:2, y:0, value:nil) }

    context 'when given the target cell to change and the symbol to change to' do
      it 'sends a message to the target Cell to update its value' do
        current_symbol = '???'
        expect(target_cell).to receive(:update_value).with(current_symbol)
        board_update.update_cells(target_cell, current_symbol)
      end
    end
  end

  describe '#full?' do
    context 'when all Cells of the Board have a non-nil @value' do
      subject(:board_full) { described_class.new }
      
      before do
        @cells.each do |cell|
          allow(cell).to receive(:value).and_return('???')
        end
        board_full.instance_variable_set(:@cells, @cells)
      end

      it 'returns true' do
        expect(board_full.full?).to be true
      end
    end

    context 'when at least one Board Cell has a nil @value' do
      subject(:board_not_full) { described_class.new }
      
      before do
        @cells.each do |cell|
          allow(cell).to receive(:value).and_return('???')
        end
        allow(@cells[3]).to receive(:value).and_return(nil)
        board_not_full.instance_variable_set(:@cells, @cells)
      end

      it 'returns false' do
        expect(board_not_full.full?).to be false
      end
    end
  end



  describe '#winner?' do
    # Iterate through the Cells of the Board 
    # For each Cell, check if its value is nil 
    # if it is not, loop in 4 directions to look for a winning state
    # Do any of the 4 directions contain a winning state?

    context 'when the board is freshly created' do
      subject(:board_fresh) { described_class.new }  
      
      before do
        board_fresh.instance_variable_set(:@cells, @cells)
      end

      it 'returns false' do
        expect(board_fresh.winner?).to be false
      end
    end

    context 'when the board is partly filled, but there is no winning state' do
      subject(:board_no_win) { described_class.new }
      before do
        allow(@cells[0]).to receive(:value).and_return('???')
        allow(@cells[1]).to receive(:value).and_return('???')

        allow(Cell).to receive(:find).and_return(@cells[1], @cells[2], @cells[2], @cells[3])
        board_no_win.instance_variable_set(:@cells, @cells)
      end

      it 'returns false' do
        expect(board_no_win.winner?).to be false
      end
    end

    context "when there is a winning state on the board" do
      subject(:board_win) { described_class.new }
      before do
        allow(@cells[0]).to receive(:value).and_return('???')
        allow(@cells[1]).to receive(:value).and_return('???')
        allow(@cells[2]).to receive(:value).and_return('???')
        allow(@cells[3]).to receive(:value).and_return('???')

        allow(Cell).to receive(:find).and_return(@cells[1], @cells[2], @cells[3])
        board_win.instance_variable_set(:@cells, @cells)
      end

      it 'returns true' do
        expect(board_win.winner?).to be true
      end
    end
  end

  describe '#direction_win?' do
    # Given a Cell and a Direction, loop in that direction to check for a winner
    # Loop until either a winner is found or a winner is deconfirmed
    context 'starting at Cell(0,0), looping up' do
      subject(:board_search_up) { described_class.new }
      
      before do
        @up = { x:0, y: 1 }
      end

      context "when Cell(0,0)'s @value is ??? and Cell(0, 1)'s value is nil" do
        before do
          allow(@cells[0]).to receive(:value).and_return('???') 
        end
        
        it 'does not loop; returns false' do
          expect(board_search_up.direction_win?(@cells[0], @up)).to be false
        end

        it 'sends ::find to Cell with the coordinates of the next cell' do
          next_x = 0
          next_y = 1
          allow(Cell).to receive(:find).with(next_x, next_y).and_return(@cells[1])
          expect(Cell).to receive(:find).with(next_x, next_y)
          board_search_up.direction_win?(@cells[0], @up)
        end
      end
      
      context "when Cell(0,0) and Cell(0,1)'s @value are ??? and Cell(0,2)'s value is ???" do
        before do
          allow(@cells[0]).to receive(:value).and_return('???') 
          allow(@cells[1]).to receive(:value).and_return('???') 
          allow(@cells[2]).to receive(:value).and_return('???') 
        end
        
        it 'completes the loop once, then returns false on the second loop (???)' do
          allow(Cell).to receive(:find).and_return(@cells[1], @cells[2])
          expect(Cell).to receive(:find).twice
          board_search_up.direction_win?(@cells[0], @up)
        end

        it 'returns false' do
          expect(board_search_up.direction_win?(@cells[0], @up)).to be false
        end
      end

      context "when Cell(0,0), (0,1), (0,2), and (0,3)'s @value are all ???" do
        before do
          allow(@cells[0]).to receive(:value).and_return('???')
          allow(@cells[1]).to receive(:value).and_return('???')
          allow(@cells[2]).to receive(:value).and_return('???')
          allow(@cells[3]).to receive(:value).and_return('???')
        end

        it 'completes the loop 3 times and returns true' do
          allow(Cell).to receive(:find).and_return(@cells[1], @cells[2], @cells[3])
          expect(Cell).to receive(:find).exactly(3).times
          board_search_up.direction_win?(@cells[0], @up)
        end

        it 'returns true' do
          allow(Cell).to receive(:find).and_return(@cells[1], @cells[2], @cells[3])
          expect(board_search_up.direction_win?(@cells[0], @up)).to be true
        end
      end

      context "when the starting cell is less than 4 cells from the edge" do
        context "starting at Cell(0, 3), looking up" do
          before do
            allow(@cells[3]).to receive(:value).and_return('???')
            allow(Cell).to receive(:find).and_return(nil)
          end

          it 'returns false' do
            expect(board_search_up.direction_win?(@cells[3], @up)).to be false
          end
        end

        context "starting at Cell(0, 2), looking up" do
          before do
            allow(@cells[2]).to receive(:value).and_return('???')
            allow(@cells[3]).to receive(:value).and_return('???')
            allow(Cell).to receive(:find).and_return(@cells[3], nil)
          end

          it 'returns false' do
            expect(board_search_up.direction_win?(@cells[2], @up)).to be false
          end
        end
      end
    end
  end
end

describe Cell do
  describe '#initialize' do
    # Initialize - Do not need to test
  end

  describe '::find' do
    context 'when given an x and y value' do
      before do
        @x = 0
        @y = 1
      end

      it 'returns the Cell object with that x and y value' do
        return_cell = Cell.find(@x, @y)
        expect(return_cell.x).to eq(@x)
        expect(return_cell.y).to eq(@y)
      end
    end
  end

  describe '#update_value' do
    x = 2
    y = 0
    subject (:cell_update) { described_class.new(x, y) }
    
    context 'when given the current player symbol' do
      it 'updates @value to the symbol' do
        symbol = '???'
        expect { cell_update.update_value(symbol) }.to change { cell_update.value }.to(symbol)
      end
    end
  end

  
  
end


