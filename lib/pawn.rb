# represents a pawn chess piece
class Pawn
  def initialize(player, row, column)
    @player = player
    @row = row
    @column = column
    @moves = 0
  end
end