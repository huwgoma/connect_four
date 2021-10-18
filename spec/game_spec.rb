# frozen_string_literal: true
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  before do 
    allow(STDOUT).to receive(:write)
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
end