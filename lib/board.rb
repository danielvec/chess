require 'colorize'

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
        @board[row][column] = if row.odd? && column.even? || row.even? && column.odd?
                                @board[row][column].on_white
                              else
                                @board[row][column].on_blue
                              end
      end
    end 
  end

  def display_board
    color_board
    (0..9).each do |i|
      puts @board[i].join('')
    end
  end
end

c = Board.new
c.display_board