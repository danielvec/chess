require_relative 'piece'

# represents a rook chess piece
class Rook < Piece
  attr_accessor :move_count

  def initialize(player, row, column, board)
    super
    @move_count = 0
  end

  def symbol
    " \u265C "
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