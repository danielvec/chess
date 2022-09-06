class Castling

  attr_reader :player, :side
  attr_accessor :board

  def initialize(player, side, board)
    @player = player
    @side = side
    @board = board
  end

  def castle
    if king.move_count.zero? && empty_spaces? && rook.move_count.zero? && !castle_check?
      board.color_board
      if player == 1
        if side == "left"
          board.highlight_space(8, 3)
        elsif side == "right"
          board.highlight_space(8, 7)
        end
      elsif player == 2
        if side == "left"
          board.highlight_space(1, 3)
        elsif side == "right"
          board.highlight_space(1, 7)
        end
      end
    end
  end

  def empty_spaces?
    if player == 1
      if side == "left"
        board.empty_space?(8, 3) && board.empty_space?(8, 4)
      elsif side == "right"
        board.empty_space?(8, 6) && board.empty_space?(8, 7)
      end
    elsif player == 2
      if side == "left"
        board.empty_space?(1, 3) && board.empty_space?(1, 4)
      elsif side == "right"
        board.empty_space?(1, 6) && board.empty_space?(1, 7)
      end
    end
  end

  def king
    if player == 1
      board.white_pieces[15]
    elsif player == 2
      board.black_pieces[15]
    end
  end

  def rook
    if player == 1
      if side == "left"
        board.white_pieces[8]
      elsif side == "right"
        board.white_pieces[9]
      end
    elsif player == 2
      if side == "left"
        board.black_pieces[8]
      elsif side == "right"
        board.black_pieces[9]
      end
    end
  end

  def castle_check?
    if player == 1
      board.highlight_black_moves
      if side == "left"
        board.valid_move?(8, 3) || board.valid_move?(8, 4) || board.valid_move?(8, 5)
      elsif side == "right"
        board.valid_move?(8, 5) || board.valid_move?(8, 6) || board.valid_move?(8, 7)
      end
    elsif player == 2
      board.highlight_white_moves
      if side == "left"
        board.valid_move?(1, 3) || board.valid_move?(1, 4) || board.valid_move?(1, 5)
      elsif side == "right"
        board.valid_move?(1, 5) || board.valid_move?(1, 6) || board.valid_move?(1, 7)
      end
    end
  end
end
