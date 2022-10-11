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
    if white_check?
      if !any_valid_moves?(white_king, 1)
        puts "Checkmate."
        exit
      end
      in_check(1, 2)
    else
      board.color_board
      board.highlight_white_moves
      if !any_valid_moves?(white_king, 1)
        puts "Stalemate."
        exit
      end
    end
    board.color_board
    piece = piece_selection(@player_one, 1)
    display_moves(piece, 1)
    no_moves(1) if !valid_moves?(1)
    move_selection(@player_one, piece, 1)
    disable_en_passant(1)
    board.color_board
    board.display_board
    player_two_turn
  end

  def player_two_turn
    if black_check?
      if !any_valid_moves?(black_king, 2)
        puts "Checkmate."
        exit
      end
      in_check(2, 1)
    else
      board.color_board
      board.highlight_black_moves
      if !any_valid_moves?(black_king, 2)
        puts "Stalemate."
        exit
      end
    end
    board.color_board
    piece = piece_selection(@player_two, 2)
    display_moves(piece, 2)
    no_moves(2) if !valid_moves?(2)
    move_selection(@player_two, piece, 2)
    disable_en_passant(2)
    board.color_board
    board.display_board
    player_one_turn
  end

  def in_check(player, opponent)
    checkmate = verify_checkmate(player)
    if checkmate.game_over?
      puts "Checkmate. Player #{opponent} wins."
      exit
    else
      puts "CHECK"
    end
  end

  def invalidate_moves(piece, king, player)
    invalid_moves = []
    piece_moves = valid_moves
    board.remove_piece(piece.row, piece.column)
    until piece_moves.empty?
      row = piece_moves[0][0]
      column = piece_moves[0][1]
      current_piece = active_piece(row, column, king)
      deactivate_piece(current_piece)
      board.board[row][column] = "#{piece}"
      board.color_board
      if piece.is_a? King
        king == black_king ? board.highlight_white_moves : board.highlight_black_moves
        invalid_moves << [row, column] if board.valid_move?(row, column)
      else
        invalid_moves << [row, column] if player_check?(player)
      end
      board.remove_piece(row, column)
      reactivate_piece(row, column, current_piece)
      piece_moves.delete_at 0
    end
    board.board[piece.row][piece.column] = "#{piece}"
    board.color_board
    potential_moves(piece, player)
    unhighlight_moves(invalid_moves)
    valid_moves
  end

  def any_valid_moves?(king, player)
    board.color_board
    pieces = king == white_king ? board.white_pieces : board.black_pieces
    (0...pieces.length).each do |i|
      if pieces[i].active?
        return true unless invalidate_moves(pieces[i], king, player).empty?
      end
    end
    return false
  end

  def deactivate_piece(piece)
    if piece.respond_to?(:update_location)
      piece.deactivate
    end
  end

  def reactivate_piece(row, column, piece)
    if piece.respond_to?(:update_location)
      piece.activate(row, column)
      board.board[row][column] = "#{piece}"
    end
  end

  def potential_moves(piece, player)
    castling_moves(piece, player) if piece.is_a? King
    piece.possible_moves
  end

  def active_piece(row, column, king)
    pieces = king == black_king ? board.white_pieces : board.black_pieces
    (0...pieces.length).each do |i|
      if pieces[i].row == row && pieces[i].column == column
        return pieces[i]
      end
    end
  end

  def player_check?(player)
    board.color_board
    if player == 1
      white_check?
    else
      black_check?
    end
  end

  def unhighlight_moves(moves)
    for i in 0...moves.length
      row = moves[i][0]
      column = moves[i][1]
      board.color_square(row, column)
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

  def no_moves(player)
    puts "Selected piece has no valid moves."
    if player == 1
      player_one_turn
    elsif player == 2
      player_two_turn
    end
  end

  def valid_moves?(player)
    !valid_moves.empty?
  end

  def valid_moves
    valid_spaces = []
    (1..8).each do |column|
      (1..8).each do |row|
        valid_spaces << [row, column] if board.valid_move?(row, column)
      end
    end
    valid_spaces
  end

  def piece_selection(player, user)
    board.color_board
    chosen_piece = player.choose_piece(user)
    board.selected_piece(user, chosen_piece[0], chosen_piece[1])
  end

  def display_moves(selected_piece, player)
    potential_moves(selected_piece, player)
    if player == 1
      invalidate_moves(selected_piece, white_king, player)
    else
      invalidate_moves(selected_piece, black_king, player)
    end
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

  def white_king_attacker
    board.color_board
    (0...board.black_pieces.length).each do |i|
      board.black_pieces[i].possible_moves if board.black_pieces[i].active?
      if check?(white_king)
        return board.black_pieces[i]
      end
    end
  end

  def black_king_attacker
    board.color_board
    (0...board.white_pieces.length).each do |i|
      board.white_pieces[i].possible_moves if board.white_pieces[i].active?
      if check?(black_king)
        return board.white_pieces[i]
      end
    end
  end

  def white_king
    board.white_pieces[board.white_pieces.length - 1]
  end

  def black_king
    board.black_pieces[board.black_pieces.length - 1]
  end

  def disable_en_passant(player)
    if player == 1
      (0..board.black_pieces.length - 1).each do |i|
        board.black_pieces[i].en_passant = false if defined? board.black_pieces[i].en_passant
      end
    elsif player == 2
      (0..board.white_pieces.length - 1).each do |i|
        board.white_pieces[i].en_passant = false if defined? board.white_pieces[i].en_passant
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
