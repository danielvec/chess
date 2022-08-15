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
      " \u265F ".white
    elsif player == 2
      " \u265F ".black
    end
  end

  def move_options
    if player == 1
      highlight_options(- 1)
    elsif player == 2
      highlight_options(1)
    end
  end

  def highlight_options(direction)
    if board.empty_space?(row + direction, column)
      board.highlight_space(row + direction, column)
      if moves.zero? && board.empty_space?(row + direction + direction, column)
        board.highlight_space(row + direction + direction, column)
      end
    end
  end

end