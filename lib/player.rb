require_relative 'board'

#represents a player of chess
class Player
  attr_reader :color

  def initialize(color, board = Board.new)
    @color = color
    @board = board
  end

  def choose_piece
    loop do
      puts "Choose the piece you would like to move, letter then number, e.g., B2"
      row, column = select_square
      return row, column if valid_piece?(row, column)

      puts "Not a valid piece!"
    end
  end

  def select_square
    loop do
      user_input = gets.capitalize.chomp
      validated_input = validate_input(user_input)
      return validated_input if validated_input

      puts "Input Error!"
    end
  end

  def validate_input(input)
    column = input.split('')[0].ord - 64
    row = (input.split('')[1].to_i - 9).abs
    return row, column if column.between?(1, 8) && row.between?(1, 8)
  end

  def move_piece
    loop do
      puts "Select the space you would like to move to"
      row, column = select_square
      return row, column if @board.valid_move?(row, column)

      puts "Invalid move!"
    end
  end

  private

  def valid_piece?(row, column)
    @board.piece_color(row, column) == color
  end
end

#new_player = Player.new("white")
#p new_player.choose_piece