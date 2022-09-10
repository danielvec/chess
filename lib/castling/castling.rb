class Castling
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def castle
    if moves(king).zero? && empty_spaces? && moves(rook).zero? && !castle_check?
      board.color_board
      possible_king_move.map { |row, column| board.highlight_space(row, column) }
    end
  end

  def empty_spaces?
    spaces_between.all? { |row, column| board.empty_space?(row, column) }
  end

  def castle_check?
    king_path.any? { |row, column| board.valid_move?(row, column) }
  end

  def moves(piece)
    piece.move_count
  end
end
