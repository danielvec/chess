# represents a pawn chess piece
class Pawn
  attr_reader :player, :board
  attr_accessor :moves, :row, :column
  
  def initialize(player, row, column, board)
    @player = player
    @row = row
    @column = column
    @board = board
    @moves = 0
  end

  def to_s
    if player == 1
      " \u265F ".white
    elsif player == 2
      " \u265F ".black
    end
  end

  def possible_moves
    if player == 1
      move_options(- 1)
      capture_options(- 1)
    elsif player == 2
      move_options(1)
      capture_options(1)
    end
  end

  def move_options(direction)
    if board.empty_space?(row + direction, column)
      board.highlight_space(row + direction, column)
      if moves.zero? && board.empty_space?(row + direction + direction, column)
        board.highlight_space(row + direction + direction, column)
      end
    end
  end

  def capture_options(direction)
    if column > 1 && board.piece_color(row + direction, column - 1) == opponent_color
      board.highlight_space(row + direction, column - 1)
    end
    if column < 8 && board.piece_color(row + direction, column + 1) == opponent_color
      board.highlight_space(row + direction, column + 1)
    end
  end

  def update_location(new_row, new_column)
    self.row = new_row
    self.column = new_column
    self.moves += 1
  end

  private

  def opponent_color
    if player == 1
      "black"
    elsif player == 2
      "white"
    end
  end
end