require 'colorize'
require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'

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
  end

  def color_board
    (1..8).each do |column|
      (1..8).each do |row|
        board[row][column] = if row.odd? && column.even? || row.even? && column.odd?
                                board[row][column].on_light_blue
                              else
                                board[row][column].on_blue
                              end
      end
    end 
  end

  def display_board
    puts "captured: #{white_captured}".white.on_light_cyan
    (0..9).each do |i|
      puts board[i].join('')
    end
    puts "captured: #{black_captured}".black.on_light_cyan
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
    (0..11).each do |i|
      if player == 1
        if white_pieces[i].row == row && white_pieces[i].column == column
          return white_pieces[i]
        end
      elsif player == 2
        if black_pieces[i].row == row && black_pieces[i].column == column
          return black_pieces[i]
        end
      end
    end
  end

  def valid_move?(row, column)
    board[row][column] == board[row][column].on_red
  end

  def move_piece(piece, row, column)
    add_captured(row, column) unless empty_space?(row, column)
    board[piece.row][piece.column] = "   "
    board[row][column] = "#{piece}"
    piece.update_location(row, column)
  end

  def add_captured(row, column)
    if piece_color(row, column) == "black"
      black_captured << board[row][column].split[1]
    elsif piece_color(row, column) == "white"
      white_captured << board[row][column].split[1]
    end
  end

  def empty_space?(row, column)
    board[row][column].include? "   "
  end
end

#c = Board.new
#c.color_board
#c.highlight_space(5,5)
#c.display_board
#puts c.possible_moves(7, 2)
