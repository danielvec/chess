require_relative 'piece'

# represents a bishop chess piece
class Bishop < Piece

  def symbol
    " \u265D "
  end

  def moves
    [method(:move_up_right), method(:move_up_left), method(:move_down_right), 
     method(:move_down_left)]
  end

  def possible_moves
    move_up_right
    move_up_left
    move_down_right
    move_down_left
  end
  
  def move_up_right(new_row = row, new_column = column)
    if board.empty_space?(new_row - 1, new_column + 1) || opponent_piece?(new_row - 1, new_column + 1)
      board.highlight_space(new_row - 1, new_column + 1)
      move_up_right(new_row - 1, new_column + 1) unless opponent_piece?(new_row - 1, new_column + 1)
    end
  end
  
  def move_up_left(new_row = row, new_column = column)
    if board.empty_space?(new_row - 1, new_column - 1) || opponent_piece?(new_row - 1, new_column - 1)
      board.highlight_space(new_row - 1, new_column - 1)
      move_up_left(new_row - 1, new_column - 1) unless opponent_piece?(new_row - 1, new_column - 1)
    end
  end
  
  def move_down_right(new_row = row, new_column = column)
    if board.empty_space?(new_row + 1, new_column + 1) || opponent_piece?(new_row + 1, new_column + 1)
      board.highlight_space(new_row + 1, new_column + 1)
      move_down_right(new_row + 1, new_column + 1) unless opponent_piece?(new_row + 1, new_column + 1)
    end
  end
  
  def move_down_left(new_row = row, new_column = column)
    if board.empty_space?(new_row + 1, new_column - 1) || opponent_piece?(new_row + 1, new_column - 1)
      board.highlight_space(new_row + 1, new_column - 1)
      move_down_left(new_row + 1, new_column - 1) unless opponent_piece?(new_row + 1, new_column - 1)
    end
  end
end