# frozen_string_literal: true

class Game
  def initialize(board = Board.new)
    @board = board
    @player_one = create_player(1)
    @player_two = create_player(2)
  end

  def create_player(id)
    puts "What is Player #{id}'s name?"
    name = gets.chomp
    Player.new(name, id)
  end


end