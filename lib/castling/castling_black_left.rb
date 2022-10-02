require_relative 'castling_black_left'

class CastlingBlackLeft < Castling
  def possible_king_move
    [[1, 3]]
  end

  def spaces_between
    [[1, 2], [1, 3], [1, 4]]
  end

  def king_path
    [[1, 3], [1, 4], [1, 5]]
  end

  def king
    board.black_pieces[board.black_pieces.length - 1]
  end

  def rook
    board.black_pieces[board.black_pieces.length - 8]
  end
end