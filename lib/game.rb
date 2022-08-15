require_relative 'board'
require_relative 'player'

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
    chosen_piece = @player_one.choose_piece
    selected_piece = @board.selected_pawn(1, chosen_piece[0], chosen_piece[1])
    selected_piece.move_options
    @board.display_board
    chosen_space = @player_one.move_piece
    @board.move_pawn(pawn, chosen_space[0], chosen_space[1])
    @board.color_board
    @board.display_board
    player_two_turn
  end

  def player_two_turn
    chosen_piece = @player_two.choose_piece
    selected_piece = @board.selected_pawn(2, chosen_piece[0], chosen_piece[1])
    selected_piece.move_options
    @board.display_board
    chosen_space = @player_two.move_piece
    @board.move_pawn(pawn, chosen_space[0], chosen_space[1])
    @board.color_board
    @board.display_board
    player_one_turn
  end
end


chess = Game.new
chess.play_game