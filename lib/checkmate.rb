class Checkmate

  attr_reader :attacker, :king, :player
  attr_accessor :board

  def initialize(attacker, king, player, board)
    @attacker = attacker
    @king = king
    @player = player
    @board = board
  end

  def game_over?
    !attack_king_attacker? && !block_attacker? && !move_king?
  end

  def attack_king_attacker?
    @board.color_board
    potential_moves
    @board.valid_move?(attacker.row, attacker.column)
  end

  def block_attacker?
    path_to_king
    opponent_path = highlighted_spaces
    @board.color_board
    potential_blocking_moves
    player_moves = highlighted_spaces
    (opponent_path & player_moves).any?
  end

  def path_to_king
    (0..attacker.moves.length - 1).each do |i|
      @board.color_board
      attacker.moves[i].call
      break if @board.valid_move?(king.row, king.column)
    end
  end

  def potential_moves
    if player == 1
      @board.highlight_white_moves
    elsif player == 2
      @board.highlight_black_moves
    end
  end

  def potential_blocking_moves
    if player == 1
      @board.highlight_white_moves(@board.white_pieces.length - 1)
    elsif player == 2
      @board.highlight_black_moves(@board.black_pieces.length - 1)
    end
  end

  def move_king?
    (king_moves - opponent_moves).any?
  end

  def opponent_moves
    @board.color_board
    if player == 1
      @board.highlight_black_moves
    elsif player == 2
      @board.highlight_white_moves
    end
    highlighted_spaces
  end

  def king_moves
    @board.color_board
    if player == 1
      @board.white_pieces[15].possible_moves
    elsif player == 2
      @board.black_pieces[15].possible_moves
    end
    highlighted_spaces
  end

  def highlighted_spaces
    spaces = []
    (1..8).each do |column|
      (1..8).each do |row|
        if @board.valid_move?(row, column)
          spaces << [row, column]
        end
      end 
    end
    spaces
  end

end