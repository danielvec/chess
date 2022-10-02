require_relative 'piece'

# represents a king chess piece
class King < Piece
  attr_accessor :move_count

  def initialize(player, row, column, board)
    super
    @move_count = 0
  end

  def symbol
    " \u265A "
  end

  def moves
    [method(:move_up), method(:move_right), method(:move_down), method(:move_left),
     method(:move_up_right), method(:move_up_left), method(:move_down_right), 
     method(:move_down_left)]
  end

  def possible_moves
    move_up
    move_right
    move_down
    move_left
    move_up_right
    move_up_left
    move_down_right
    move_down_left
  end

  def move_up(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column)
      board.highlight_space(new_row - 1, new_column)
    end 
  end

  def move_down(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column)
      board.highlight_space(new_row + 1, new_column)
    end
  end

  def move_right(new_row = row, new_column = column)
    if viable_move?(new_row, new_column + 1)
      board.highlight_space(new_row, new_column + 1)
    end
  end

  def move_left(new_row = row, new_column = column)
    if viable_move?(new_row, new_column - 1)
      board.highlight_space(new_row, new_column - 1)
    end
  end

  def move_up_right(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column + 1)
      board.highlight_space(new_row - 1, new_column + 1)
    end
  end

  def move_up_left(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column - 1)
      board.highlight_space(new_row - 1, new_column - 1)
    end
  end

  def move_down_right(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column + 1)
      board.highlight_space(new_row + 1, new_column + 1)
    end
  end

  def move_down_left(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column - 1)
      board.highlight_space(new_row + 1, new_column - 1)
    end
  end

  def adjust_move_count(change)
    self.move_count += change
  end

  def update_location(new_row, new_column)
    super
    self.move_count += 1
  end

  private

  def viable_move?(row, column)
    board.valid_space?(row, column) &&
      (board.empty_space?(row, column) || opponent_piece?(row, column))
  end
end