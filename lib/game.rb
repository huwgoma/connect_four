# frozen_string_literal: true

class Game
  attr_reader :board, :current_player

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
    
    game_loop #until board.game_over?
    
  end

  def game_loop
    target_cell = player_input
    board.update_cells(target_cell, current_player.symbol)
    board.display
    switch_current_player #unless game_over?
  end

  def player_input
    puts "#{current_player.name}, please enter a number (1-7) where you would like to place your piece."
    loop do
      user_input = gets.chomp.to_i
      verified_number = verify_number(user_input)
      
      unless verified_number 
        puts "Please enter a valid number between 1-7!"
        next
      end

      target_cell = board.find_column_cell(verified_number)
      return target_cell if target_cell
      puts 'That column is full! Please enter another number.'
    end
  end

  def verify_number(number)
    return number if number.between?(1, 7)
  end

  def switch_current_player
    @current_player = @current_player.id == 1 ? @player_two : @player_one
  end

  
end