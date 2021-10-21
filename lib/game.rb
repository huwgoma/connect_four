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
    target_cell = player_input
  end

  def player_input
    loop do
      user_input = gets.chomp.to_i
      verified_number = verify_number(user_input)
      unless verified_number
        puts "Please enter a valid number between 1-7!"
        next
      end
      target_cell = verify_column(verified_number)

      #return target_cell if target_cell
      break
      
      
      
    end
  end

  def verify_column(input)
    target_column = board.find_column(input - 1)
    target_cell = board.find_lowest_cell(target_column)
  end

  def verify_number(number)
    return number if number.between?(1, 7)
  end
end