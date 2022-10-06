require 'colorize'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/queen'
require_relative 'pieces/king'

#represents a chess board
class Board
  attr_accessor :board, :white_pieces, :black_pieces, :white_captured, :black_captured

  def initialize
    @board = [["   ", " A ", " B ", " C ", " D ", " E ", " F ", " G ", " H "],
              [" 8 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 8 "],
              [" 7 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 7 "],
              [" 6 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 6 "],
              [" 5 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 5 "],
              [" 4 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 4 "],
              [" 3 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 3 "],
              [" 2 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 2 "],
              [" 1 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 1 "],
              ["   ", " A ", " B ", " C ", " D ", " E ", " F ", " G ", " H "]]
    @white_pieces = []
    @black_pieces = []
    @white_captured = []
    @black_captured = []
    add_pawns
    add_rooks
    add_bishops
    add_knights
    add_queens
    add_kings
  end

  def color_board
    (1..8).each do |column|
      (1..8).each do |row|
        color_square(row, column)
      end
    end 
  end

  def color_square(row, column)
    board[row][column] = if row.odd? && column.even? || row.even? && column.odd?
                          board[row][column].on_light_blue
                         else
                          board[row][column].on_blue
                         end
  end

  def display_board
    puts "captured: #{white_captured}".light_white.on_blue
    (0..9).each do |i|
      puts board[i].join('')
    end
    puts "captured: #{black_captured}".black.on_light_blue
  end

  def add_pawns
    (1..8).each do |column|
      @white_pieces << Pawn.new(1, 7, column, self)
      @black_pieces << Pawn.new(2, 2, column, self)
      board[7][column] = "#{white_pieces[column - 1]}"
      board[2][column] = "#{black_pieces[column - 1]}"
    end
  end

  def add_rooks
    @white_pieces << Rook.new(1, 8, 1, self) << Rook.new(1, 8, 8, self) 
    @black_pieces << Rook.new(2, 1, 1, self) << Rook.new(2, 1, 8, self)
    board[8][1] = "#{white_pieces[8]}"
    board[8][8] = "#{white_pieces[9]}"
    board[1][1] = "#{black_pieces[8]}"
    board[1][8] = "#{black_pieces[9]}"
  end

  def add_bishops
    @white_pieces << Bishop.new(1, 8, 3, self) << Bishop.new(1, 8, 6, self)
    @black_pieces << Bishop.new(2, 1, 3, self) << Bishop.new(2, 1, 6, self)
    board[8][3] = "#{white_pieces[10]}"
    board[8][6] = "#{white_pieces[11]}"
    board[1][3] = "#{black_pieces[10]}"
    board[1][6] = "#{black_pieces[11]}"
  end

  def add_knights
    @white_pieces << Knight.new(1, 8, 2, self) << Knight.new(1, 8, 7, self)
    @black_pieces << Knight.new(2, 1, 2, self) << Knight.new(2, 1, 7, self)
    board[8][2] = "#{white_pieces[12]}"
    board[8][7] = "#{white_pieces[13]}"
    board[1][2] = "#{black_pieces[12]}"
    board[1][7] = "#{black_pieces[13]}"
  end

  def add_queens
    @white_pieces << Queen.new(1, 8, 4, self)
    @black_pieces << Queen.new(2, 1, 4, self)
    board[8][4] = "#{white_pieces[14]}"
    board[1][4] = "#{black_pieces[14]}"
  end

  def add_kings
    @white_pieces << King.new(1, 8, 5, self)
    @black_pieces << King.new(2, 1, 5, self)
    board[8][5] = "#{white_pieces[15]}"
    board[1][5] = "#{black_pieces[15]}"
  end
  
  def piece_color(row, column)
    if board[row][column].split(";")[1] == "30"
      "black"
    elsif board[row][column].split(";")[1] == "37"
      "white"
    end
  end

  def highlight_space(row, column)
    board[row][column] = board[row][column].on_red
  end

  def selected_piece(player, row, column)
    pieces = player == 1 ? white_pieces : black_pieces
    (0...pieces.length).each do |i|
      if pieces[i].row == row && pieces[i].column == column
        return pieces[i]
      end
    end
  end

  def valid_move?(row, column)
    board[row][column] == board[row][column].on_red
  end

  def move_piece(piece, row, column)
    add_captured(row, column) unless empty_space?(row, column)
    piece.previous_location(piece.row, piece.column)
    board[piece.row][piece.column] = "   "
    board[row][column] = "#{piece}"
    piece.update_location(row, column)
    castling(piece)
    update_en_passant(piece)
    promotion(piece)
  end

  def undo_move(piece)
    if defined? piece.move_count
      piece.adjust_move_count(-2)
    end
    move_piece(piece, piece.previous_row, piece.previous_column)
  end

  def add_captured(row, column)
    if piece_color(row, column) == "black"
      captured = selected_piece(2, row, column)
      captured.deactivate
      black_captured << captured.to_s.split[1]
    elsif piece_color(row, column) == "white"
      captured = selected_piece(1, row, column)
      captured.deactivate
      white_captured << captured.to_s.split[1]
    end
  end

  def valid_space?(row, column)
    row.between?(1, 8) && column.between?(1, 8)
  end

  def empty_space?(row, column)
    board[row][column].include? "   "
  end

  def remove_piece(row, column)
    board[row][column] = "   "
  end

  def highlight_black_moves(pieces = black_pieces.length)
    (0..(pieces - 1)).each do |i|
      black_pieces[i].possible_moves if black_pieces[i].active?
    end
  end

  def highlight_white_moves(pieces = white_pieces.length)
    (0..(pieces - 1)).each do |i|
      white_pieces[i].possible_moves if white_pieces[i].active?
    end
  end

  def update_en_passant(piece)
    if (piece.is_a? Pawn) && (piece.row - piece.previous_row).abs == 2
      piece.en_passant = true
    end
  end

  def castling(piece)
    if (piece.is_a? King) && (piece.column - piece.previous_column).abs == 2
      move_piece(castling_rook(piece), piece.row, castling_column(piece))
    end
  end

  def promotion(piece)
    player = piece_color(piece.row, piece.column) == "white" ? 1 : 2
    if (piece.is_a? Pawn) && (piece.row == 1 || piece.row == 8)
      promotion_choice(player, piece.row, piece.column)
      piece.deactivate
    end
  end

  def promotion_choice(player, row, column)
    puts "Enter 'Q' for Queen, 'R' for Rook, 'K' for Knight, or 'B' for Bishop"
    choice = gets.chomp
    player_pieces = player == 1 ? @white_pieces : @black_pieces
    case choice.upcase
    when 'Q'
      player_pieces.unshift(Queen.new(player, row, column, self))
    when 'R'
      player_pieces.unshift(Rook.new(player, row, column, self))
    when 'K'
      player_pieces.unshift(Knight.new(player, row, column, self))
    when 'B'
      player_pieces.unshift(Bishop.new(player, row, column, self))
    else promotion_choice(player, row, column)
    end
    board[row][column] = "#{player_pieces[0]}"
  end

  def castling_rook(king)
    if king.column == 3 && king.row == 8
      white_pieces[white_pieces.length - 8]
    elsif king.column == 7 && king.row == 8
      white_pieces[white_pieces.length - 7]
    elsif king.column == 3 && king.row == 1
      black_pieces[black_pieces.length - 8]
    elsif king.column == 7 && king.row == 1
      black_pieces[black_pieces.length - 7]
    end
  end

  def castling_column(king)
    (king.column + king.previous_column) / 2
  end
end
