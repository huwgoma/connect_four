# frozen_string_literal: true

class Player
  def initialize(name, id)
    @name = name
    @id = id
    @symbol = @id == 1 ? '⚪' : '⚫'
  end
end