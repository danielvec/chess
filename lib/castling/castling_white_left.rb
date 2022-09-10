require_relative 'castling'

class CastlingWhiteLeft < Castling
  def possible_king_move
    [[8, 3]]
  end

  def spaces_between
    [[8, 2], [8, 3], [8, 4]]
  end

  def king_path
    [[8, 3], [8, 4], [8, 5]]
  end

  def king
    board.white_pieces[15]
  end

  def rook
    board.white_pieces[8]
  end
end