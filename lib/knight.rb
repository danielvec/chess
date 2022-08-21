# represents a bishop chess piece
class Knight
  attr_reader :player, :board
  attr_accessor :row, :column

  def initialize(player, row, column, board)
    @player = player
    @row = row
    @column = column
    @board = board
  end

  def to_s
    if player == 1
      " \u265E ".white
    elsif player == 2
      " \u265E ".black
    end
  end

  def possible_moves
    move_options = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    (0..7).each do |i|
      move(move_options[i][0], move_options[i][1])
    end
  end

  def move(row_direction, column_direction)
    if viable_move?(row + row_direction, column + column_direction)
      board.highlight_space(row + row_direction, column + column_direction)
    end
  end

  def update_location(new_row, new_column)
    self.row = new_row
    self.column = new_column
  end

  private

  def viable_move?(row, column)
    board.valid_space?(row, column) &&
      (board.empty_space?(row, column) || opponent_piece?(row, column))
  end

  def opponent_piece?(row, column)
    board.piece_color(row, column) == opponent_color
  end

  def opponent_color
    if player == 1
      "black"
    elsif player == 2
      "white"
    end
  end
end