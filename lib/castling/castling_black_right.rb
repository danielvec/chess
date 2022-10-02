require_relative 'castling_black_right'

class CastlingBlackRight < Castling
  def possible_king_move
    [[1, 7]]
  end

  def spaces_between
    [[1, 6], [1, 7]]
  end

  def king_path
    [[1, 5], [1, 6], [1, 7]]
  end

  def king
    board.black_pieces[board.black_pieces.length - 1]
  end

  def rook
    board.black_pieces[board.black_pieces.length - 7]
  end
end