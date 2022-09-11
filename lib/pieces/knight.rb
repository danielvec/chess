require_relative 'piece'

# represents a bishop chess piece
class Knight < Piece

  def symbol
    " \u265E "
  end

  def moves
    [method(:up_right_right), method(:up_left_left), method(:down_right_right),
     method(:down_left_left), method(:up_up_right), method(:up_up_left),
     method(:down_down_right), method(:down_down_left)]
  end

  def possible_moves
    up_right_right
    up_left_left
    down_right_right
    down_left_left
    up_up_right
    up_up_left
    down_down_left
    down_down_right
  end

  def up_up_right(new_row = row, new_column = column)
    if viable_move?(new_row + 2, new_column + 1)
      board.highlight_space(new_row + 2, new_column + 1)
    end  
  end
  
  def up_up_left(new_row = row, new_column = column)
    if viable_move?(new_row + 2, new_column -1)
      board.highlight_space(new_row + 2, new_column - 1)
    end
  end
  
  def down_down_right(new_row = row, new_column = column)
    if viable_move?(new_row - 2, new_column + 1)
      board.highlight_space(new_row - 2, new_column + 1)
    end
  end
  
  def down_down_left(new_row = row, new_column = column)
    if viable_move?(new_row - 2, new_column - 1)
      board.highlight_space(new_row - 2, new_column - 1)
    end
  end
  
  def up_right_right(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column + 2)
      board.highlight_space(new_row + 1, new_column + 2)
    end
  end
  
  def up_left_left(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column - 2)
      board.highlight_space(new_row + 1, new_column - 2)
    end
  end
  
  def down_right_right(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column + 2)
      board.highlight_space(new_row - 1, new_column + 2)
    end
  end
  
  def down_left_left(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column - 2)
      board.highlight_space(new_row - 1, new_column - 2)
    end
  end

  private

  def viable_move?(row, column)
    board.valid_space?(row, column) &&
      (board.empty_space?(row, column) || opponent_piece?(row, column))
  end
end