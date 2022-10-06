require_relative 'board'
require_relative 'player'
require_relative 'checkmate'
require_relative 'save'
require_relative 'castling/castling_white_left'
require_relative 'castling/castling_white_right'
require_relative 'castling/castling_black_left'
require_relative 'castling/castling_black_right'

class Game
  attr_accessor :board

  def initialize(board = Board.new, save = Save.new(board), player_one = Player.new("white", board), player_two = Player.new("black", board))
    @board = board
    @save = save
    @player_one = player_one
    @player_two = player_two
  end

  def play_game
    board.color_board
    board.display_board
    player_one_turn
  end

  def player_one_turn
    in_check(1, 2) if white_check?
    piece = piece_selection(@player_one, 1)
    display_moves(piece, 1)
    move_selection(piece)
    disable_en_passant(1)
    into_check(piece, 1) if white_check?
    board.color_board
    board.display_board
    player_two_turn
  end

  def player_two_turn
    in_check(2, 1) if black_check?
    piece = piece_selection(@player_two, 2)
    display_moves(piece, 2)
    move_selection(piece)
    disable_en_passant(2)
    into_check(piece, 2) if black_check?
    board.color_board
    board.display_board
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
      Checkmate.new(white_king_attacker, white_king, 1, board)
    elsif player == 2
      Checkmate.new(black_king_attacker, black_king, 2, board)
    end
  end

  def white_check?
    board.highlight_black_moves
    check?(white_king)
  end

  def black_check?
    board.highlight_white_moves
    check?(black_king)
  end

  def piece_selection(player, user)
    board.color_board
    chosen_piece = player.choose_piece(user)
    board.selected_piece(user, chosen_piece[0], chosen_piece[1])
  end

  def display_moves(selected_piece, player)
    castling_moves(selected_piece, player)
    selected_piece.possible_moves
    board.display_board
  end

  def castling_moves(selected_piece, player)
    if player == 1
      castling_queenside = CastlingWhiteLeft.new(board)
      castling_kingside = CastlingWhiteRight.new(board)
    elsif player == 2
      castling_queenside = CastlingBlackLeft.new(board)
      castling_kingside = CastlingBlackRight.new(board)
    end
    if selected_piece.is_a? King
      castling_queenside.castle
      castling_kingside.castle
    end
  end

  def move_selection(player, selected_piece, user)
    chosen_space = player.move_piece(user)
    board.move_piece(selected_piece, chosen_space[0], chosen_space[1])
  end

  def into_check(selected_piece, player)
    puts "Puts king into check. Invalid Move"
    board.undo_move(selected_piece)
    if player == 1
      player_one_turn
    elsif player == 2
      player_two_turn
    end
  end

  def white_king_attacker
    board.color_board
    (0..15).each do |i|
      board.black_pieces[i].possible_moves
      if check?(white_king)
        return board.black_pieces[i]
      end
    end
  end

  def black_king_attacker
    board.color_board
    (0..15).each do |i|
      board.white_pieces[i].possible_moves
      if check?(black_king)
        return board.white_pieces[i]
      end
    end
  end

  def white_king
    board.white_pieces[15]
  end

  def black_king
    board.black_pieces[15]
  end

  def disable_en_passant(player)
    if player == 1
      (0..7).each do |i|
        board.black_pieces[i].en_passant = false
      end
    elsif player == 2
      (0..7).each do |i|
        board.white_pieces[i].en_passant = false
      end
    end
  end

  def intro
    puts "Type 'L' to load game or 'N' for new game"
    input = gets.capitalize.chomp
    if input == 'N'
      play_game
    elsif input == 'L'
      load_game
    else
      puts "Input Error"
      intro
    end
  end

  def load_game
    @save.load_game
    if @save.load_game == 1
      player_one_turn
    else
      player_two_turn
    end
  end

  private

  def check?(king)
    board.valid_move?(king.row, king.column)
  end
end

chess = Game.new
chess.intro