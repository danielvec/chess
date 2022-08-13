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
      user_input = gets.capitalize.chomp
      validated_input = validate_input(user_input)
      return validated_input if validated_input

      puts "Input Error!"
    end
  end

  def validate_input(input)
    column = input.split('')[0].ord - 64
    row = (input.split('')[1].to_i - 9).abs
    return input if column.between?(1, 8) && row.between?(1, 8) && valid_piece?(row, column)
  end

  private

  def valid_piece?(row, column)
    @board.piece_color(row, column) == color
  end
end

#new_player = Player.new("black")
#new_player.choose_piece