# represents a rook chess piece
class Rook
  attr_reader :player, :board
  attr_accessor :row, :column, :previous_row, :previous_column, :active
  alias_method :active?, :active
  
  def initialize(player, row, column, board)
    @player = player
    @row = row
    @column = column
    @board = board
    @previous_row = nil
    @previous_column = nil
    @active = true
  end

  def to_s
    if player == 1
      " \u265C ".white
    elsif player == 2
      " \u265C ".black
    end
  end

  def moves
    [method(:move_up), method(:move_right), method(:move_down), method(:move_left)]
  end

  def possible_moves
    move_up
    move_right
    move_down
    move_left
  end

  def move_up(new_row = row, new_column = column)
    if board.empty_space?(new_row - 1, new_column) || opponent_piece?(new_row - 1, new_column)
      board.highlight_space(new_row - 1, new_column)
      move_up(new_row - 1) unless opponent_piece?(new_row - 1, new_column)
    end
  end

  def move_down(new_row = row, new_column = column)
    if board.empty_space?(new_row + 1, new_column) || opponent_piece?(new_row + 1, new_column)
      board.highlight_space(new_row + 1, new_column)
      move_down(new_row + 1) unless opponent_piece?(new_row + 1, new_column)
    end
  end

  def move_right(new_row = row, new_column = column)
    if board.empty_space?(new_row, new_column + 1) || opponent_piece?(new_row, new_column + 1)
      board.highlight_space(new_row, new_column + 1)
      move_right(new_row, new_column + 1) unless opponent_piece?(new_row, new_column + 1)
    end
  end

  def move_left(new_row = row, new_column = column)
    if board.empty_space?(new_row, new_column - 1) || opponent_piece?(new_row, new_column - 1)
      board.highlight_space(new_row, new_column - 1)
      move_left(new_row, new_column - 1) unless opponent_piece?(new_row, new_column - 1)
    end
  end

  def previous_location(row, column)
    self.previous_row = row
    self.previous_column = column
  end

  def update_location(new_row, new_column)
    self.row = new_row
    self.column = new_column
  end

  def deactivate
    self.active = false
  end

  private

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