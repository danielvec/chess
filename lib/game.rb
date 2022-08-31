require_relative 'board'
require_relative 'player'
require_relative 'checkmate'

class Game
  def initialize(board = Board.new, player_one = Player.new("white", board), player_two = Player.new("black", board))
    @board = board
    @player_one = player_one
    @player_two = player_two
  end

  def play_game
    @board.color_board
    @board.display_board
    player_one_turn
  end

  def player_one_turn
    in_check(1, 2) if white_check?
    piece = piece_selection(@player_one, 1)
    display_moves(piece)
    move_selection(piece)
    into_check(piece, 1) if white_check?
    @board.color_board
    @board.display_board
    player_two_turn
  end

  def player_two_turn
    in_check(2, 1) if black_check?
    piece = piece_selection(@player_two, 2)
    display_moves(piece)
    move_selection(piece)
    into_check(piece, 2) if black_check?
    @board.color_board
    @board.display_board
    player_one_turn
  end

  def in_check(player, opponent)
    checkmate = verify_checkmate(player)
    if checkmate.game_over?
      puts "Checkmate. Player #{opponent} wins."
    else
      puts "CHECK"
    end
  end

  def verify_checkmate(player)
    if player == 1
      Checkmate.new(white_king_attacker, white_king, 1, @board)
    elsif player == 2
      Checkmate.new(black_king_attacker, black_king, 2, @board)
    end
  end

  def white_check?
    @board.highlight_black_moves
    check?(white_king)
  end

  def black_check?
    @board.highlight_white_moves
    check?(black_king)
  end

  def piece_selection(player, user)
    @board.color_board
    chosen_piece = player.choose_piece
    @board.selected_piece(user, chosen_piece[0], chosen_piece[1])
  end

  def display_moves(selected_piece)
    selected_piece.possible_moves
    @board.display_board
  end

  def move_selection(selected_piece)
    chosen_space = @player_one.move_piece
    @board.move_piece(selected_piece, chosen_space[0], chosen_space[1])
  end

  def into_check(selected_piece, player)
    puts "Puts king into check. Invalid Move"
    @board.undo_move(selected_piece)
    if player == 1
      player_one_turn
    elsif player == 2
      player_two_turn
    end
  end

  def white_king_attacker
    @board.color_board
    (0..15).each do |i|
      @board.black_pieces[i].possible_moves
      if check?(white_king)
        return @board.black_pieces[i]
      end
    end
  end

  def black_king_attacker
    @board.color_board
    (0..15).each do |i|
      @board.white_pieces[i].possible_moves
      if check?(black_king)
        return @board.white_pieces[i]
      end
    end
  end

  def white_king
    @board.white_pieces[15]
  end

  def black_king
    @board.black_pieces[15]
  end

  private

  def check?(king)
    @board.valid_move?(king.row, king.column)
  end
end

#chess = Game.new
#chess.play_game