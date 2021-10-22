# frozen_string_literal: true

class Player
  attr_reader :name, :symbol, :id
  
  def initialize(name, id)
    @name = name
    @id = id
    @symbol = @id == 1 ? '⬤' : '◯'
  end
end

#⬤