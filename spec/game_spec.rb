# frozen_string_literal: true
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  before do 
    allow(STDOUT).to receive(:write)

    @cells = []
    3.times do |i|
      3.times do |j|
        @cells << instance_double(Cell, x:i, y:j, value:nil)
        # [[0, 0], [0, 1], [0, 2] - Column 1
        #  [1, 0], [1, 1], [1, 2] - Column 2
        #  [2, 0], [2, 1], [2, 2]] -Column 3
      end
    end
  end

  describe '#initialize' do
    # Initialize - Test any inside methods
  end

  describe '#create_player' do
    subject(:game_player) { described_class.new }

    it 'creates two new players' do
      player_one = game_player.instance_variable_get(:@player_one)
      player_two = game_player.instance_variable_get(:@player_two)

      expect(player_one).to be_an_instance_of(Player)
      expect(player_two).to be_an_instance_of(Player)
    end
  end

  describe '#play' do
    subject(:game_play) { described_class.new }
  end

  describe '#game_loop' do
    # Script Method - Test all inside methods
    # Get the target cell (the cell to place the piece into) from #player_input
    # 
  end

  # [[0, 0], [0, 1], [0, 2] - Column 1
  #  [1, 0], [1, 1], [1, 2] - Column 2
  #  [2, 0], [2, 1], [2, 2]] -Column 3

  describe '#player_input' do
    subject(:game_input) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    before do
      #allow(board).to receive(:find_column_cell)  
      #allow(game_input).to receive(:puts).with("#{game_input.current_player.name}, please enter a number (1-7) where you would like to place your piece.")
    end

    context 'when the user enters a valid number' do
      before do
        allow(game_input).to receive(:gets).and_return('3')
        allow(board).to receive(:find_column_cell).and_return(@cells[6])
      end

      it 'does not put the number error message' do
        number_error = "Please enter a valid number between 1-7!"
        expect(game_input).to_not receive(:puts).with(number_error)
        game_input.player_input
      end
    end

    context 'when the user enters an invalid input twice, then a valid input' do
      before do
        allow(game_input).to receive(:puts)
        allow(game_input).to receive(:gets).and_return('0', '0', '3')
        allow(board).to receive(:find_column_cell).and_return(true)
      end

      it 'loops twice; puts the number error message twice' do  
        number_error = "Please enter a valid number between 1-7!"
        expect(game_input).to receive(:puts).with(number_error).twice
        game_input.player_input
      end

      it 'calls Board#find_column_cell once when the number is valid' do
        verified_number = 3
        expect(board).to receive(:find_column_cell).with(verified_number).once
        game_input.player_input
      end
    end

    context 'when given a valid number but the column is full' do
      context 'given an invalid column twice, then a valid column' do
        before do
          allow(game_input).to receive(:puts)
          allow(game_input).to receive(:gets).and_return('1', '1', '3')
          allow(board).to receive(:find_column_cell).and_return(nil, nil, true)
        end

        it 'loops twice; puts the column full error message twice' do
          column_error = 'That column is full! Please enter another number.'
          expect(game_input).to receive(:puts).with(column_error).twice
          game_input.player_input
        end
      end
    end
  end

  describe '#verify_number' do
    subject(:game_verify_number) { described_class.new }
    context 'when given a integer between 1 and 7' do
      it 'returns the integer' do
        input = 7
        expect(game_verify_number.verify_number(input)).to eq(input)
      end
    end

    context 'when given an integer not between 1 and 7' do
      it 'returns nil' do
        input = 0
        expect(game_verify_number.verify_number(input)).to be_nil
      end
    end
  end

  describe '#switch_current_player' do
    subject(:game_switch_player) { described_class.new }
    let(:player_one) { instance_double(Player, id:1) }
    let(:player_two) { instance_double(Player, id:2) }

    context 'when the @current_player is player 1' do
      before do
        game_switch_player.instance_variable_set(:@current_player, player_one)
        game_switch_player.instance_variable_set(:@player_one, player_one)
        game_switch_player.instance_variable_set(:@player_two, player_two)
      end

      it 'changes the @current_player to player 2' do
        expect { game_switch_player.switch_current_player }.to change { game_switch_player.current_player }.to(player_two)
      end
    end
  end

  describe '#replay' do
    subject(:game_replay) { described_class.new }
    let(:game_new) { described_class.new }
    
    before do
      allow(game_replay).to receive(:puts)
    end

    context 'when input is y' do
      before do
        allow(game_replay).to receive(:gets).and_return('Y')
        allow(Game).to receive(:new).and_return(game_new)
        allow(game_new).to receive(:play)
      end

      it 'sends ::clear_cells to Cell to reset @@cells between games' do
        allow(Cell).to receive(:clear_cells)
        expect(Cell).to receive(:clear_cells)
        game_replay.replay
      end
    end

    context 'when input is anything other than y' do
      before do
        allow(game_replay).to receive(:gets).and_return('n')
      end
      
      it 'does not send a message to Cell' do
        expect(Cell).to_not receive(:clear_cells)
        game_replay.replay
      end
    end
    
  end
end