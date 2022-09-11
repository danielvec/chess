require_relative 'piece'

# represents a queen chess piece
class Queen < Piece
  
  def symbol
    " \u265B "
  end

  def moves
    [method(:move_up), method(:move_right), method(:move_down),
     method(:move_left), method(:move_up_right),
     method(:move_up_left), method(:move_down_right),
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
      move_up(new_row - 1) unless opponent_piece?(new_row - 1, new_column)
    end  
  end
  
  def move_down(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column)
       board.highlight_space(new_row + 1, new_column)
      move_down(new_row + 1) unless opponent_piece?(new_row + 1, new_column)
    end
  end
  
  def move_right(new_row = row, new_column = column)
    if viable_move?(new_row, new_column + 1)
       board.highlight_space(new_row, new_column + 1)
      move_right(new_row, new_column + 1) unless opponent_piece?(new_row, new_column + 1)
    end
  end
  
  def move_left(new_row = row, new_column = column)
    if viable_move?(new_row, new_column - 1)
       board.highlight_space(new_row, new_column - 1)
      move_left(new_row, new_column - 1) unless opponent_piece?(new_row, new_column - 1)
    end
  end
  
  def move_up_right(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column + 1)
      board.highlight_space(new_row - 1, new_column + 1)
      move_up_right(new_row - 1, new_column + 1) unless opponent_piece?(new_row - 1, new_column + 1)
    end
  end
  
  def move_up_left(new_row = row, new_column = column)
    if viable_move?(new_row - 1, new_column - 1)
      board.highlight_space(new_row - 1, new_column - 1)
      move_up_left(new_row - 1, new_column - 1) unless opponent_piece?(new_row - 1, new_column - 1)
    end
  end
  
  def move_down_right(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column + 1)
      board.highlight_space(new_row + 1, new_column + 1)
      move_down_right(new_row + 1, new_column + 1) unless opponent_piece?(new_row + 1, new_column + 1)
    end
  end
  
  def move_down_left(new_row = row, new_column = column)
    if viable_move?(new_row + 1, new_column - 1)
      board.highlight_space(new_row + 1, new_column - 1)
      move_down_left(new_row + 1, new_column - 1) unless opponent_piece?(new_row + 1, new_column - 1)
    end
  end
  
  private

  def viable_move?(row, column)
    board.valid_space?(row, column) &&
      (board.empty_space?(row, column) || opponent_piece?(row, column))
  end
end