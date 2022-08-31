# represents a pawn chess piece
class Pawn
  attr_reader :player, :board
  attr_accessor :move_count, :row, :column, :previous_row, :previous_column, :active
  alias_method :active?, :active

  def initialize(player, row, column, board)
    @player = player
    @row = row
    @column = column
    @board = board
    @move_count = 0
    @previous_row = nil
    @previous_column = nil
    @active = true
  end

  def to_s
    if player == 1
      " \u265F ".white
    elsif player == 2
      " \u265F ".black
    end
  end

  def moves
    [method(:move_forward), method(:move_diagonal_left), method(:move_diagonal_right)]
  end

  def possible_moves
    move_forward
    move_diagonal_left
    move_diagonal_right
  end

  def move_forward
    if player == 1
      move_options(-1)
    elsif player == 2
      move_options(1)
    end
  end

  def move_diagonal_left
    if player == 1
      capture_left(-1)
    elsif player == 2
      capture_left(1)
    end
  end

  def move_diagonal_right
    if player == 1
      capture_right(-1)
    elsif player == 2
      capture_right(1)
    end
  end

  def move_options(direction)
    if board.empty_space?(row + direction, column)
      board.highlight_space(row + direction, column)
      if move_count.zero? && board.empty_space?(row + direction + direction, column)
        board.highlight_space(row + direction + direction, column)
      end
    end
  end

  def capture_left(direction)
    if column > 1 && board.piece_color(row + direction, column - 1) == opponent_color
      board.highlight_space(row + direction, column - 1)
    end
  end

  def capture_right(direction)
    if column < 8 && board.piece_color(row + direction, column + 1) == opponent_color
      board.highlight_space(row + direction, column + 1)
    end
  end

  def previous_location(row, column)
    self.previous_row = row
    self.previous_column = column
  end

  def adjust_move_count(change)
    self.move_count += change
  end

  def update_location(new_row, new_column)
    self.row = new_row
    self.column = new_column
    self.move_count += 1
  end

  def deactivate
    self.active = false
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