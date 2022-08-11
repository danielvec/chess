require 'colorize'
require_relative 'pawn'

#represents a chess board
class Board
  attr_accessor :board

  def initialize
    @board = [["   ", " A ", " B ", " C ", " D ", " E ", " F ", " G ", " H "],
              [" 8 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 8 "],
              [" 7 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 7 "],
              [" 6 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 6 "],
              [" 5 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 5 "],
              [" 4 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 4 "],
              [" 3 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 3 "],
              [" 3 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 3 "],
              [" 1 ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", " 1 "],
              ["   ", " A ", " B ", " C ", " D ", " E ", " F ", " G ", " H "]]
  end

  def color_board
    (1..8).each do |column|
      (1..8).each do |row|
        board[row][column] = if row.odd? && column.even? || row.even? && column.odd?
                                board[row][column].on_white
                              else
                                board[row][column].on_blue
                              end
      end
    end 
  end

  def display_board
    color_board
    (0..9).each do |i|
      puts board[i].join('')
    end
  end

  def add_pawns
    white_pawns = []
    black_pawns = []
    (1..8).each do |column|
      white_pawns << Pawn.new(1, 7, column)
      black_pawns << Pawn.new(2, 2, column)
      board[7][column] = "#{white_pawns[column - 1]}"
      board[2][column] = "#{black_pawns[column - 1]}"
    end
  end

  def piece_color(row, column)
    if board[row][column].split(";")[1] == "30"
      "black"
    elsif board[row][column].split(";")[1] == "37"
      "white"
    end
  end
end

c = Board.new
c.add_pawns
c.display_board
puts c.piece_color(2, 2)
puts c.piece_color(3, 2)