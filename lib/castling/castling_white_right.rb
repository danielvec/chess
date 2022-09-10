require_relative 'castling'

class CastlingWhiteRight < Castling
  def possible_king_move
    [[8, 7]]
  end

  def spaces_between
    [[8, 6], [8, 7]]
  end

  def king_path
    [[8, 5], [8, 6], [8, 7]]
  end

  def king
    board.white_pieces[15]
  end

  def rook
    board.white_pieces[9]
  end
end