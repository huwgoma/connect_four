# frozen_string_literal: true

class Game
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @player_one = create_player(1)
    @player_two = create_player(2)
    @current_player = @player_one
  end

  def create_player(id)
    puts "What is Player #{id}'s name?"
    name = gets.chomp
    Player.new(name, id)
  end

  def play
    board.display
  end

  def game_loop
    
  end

  def number_input 
    puts "#{@current_player.name}, please choose a column (1-7) to place your piece in."
    gets.chomp
  end

  def verify_number(number)

  end
end