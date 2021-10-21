# frozen_string_literal: true

class Player
  attr_reader :name, :symbol
  
  def initialize(name, id)
    @name = name
    @id = id
    @symbol = @id == 1 ? '◯' : '⬤'
  end
end

#⬤