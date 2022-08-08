# represents a pawn chess piece
class Pawn
  attr_reader :player
  
  def initialize(player, row, column)
    @player = player
    @row = row
    @column = column
    @moves = 0
  end

  def to_s
    if player == 1
      " \u265F "
    elsif player == 2
      " \u265F ".black
    end
  end
end