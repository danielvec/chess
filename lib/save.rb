require 'yaml'
require_relative 'board'

class Save
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def save_game(turn)
    info = { board: board.board, turn: turn, white_pieces: board.white_pieces,
             black_pieces: board.black_pieces, white_captured: board.white_captured,
             black_captured: board.black_captured }
    File.open('saved_game.yml', 'w') do |file|
      file.write(info.to_yaml)
    end
    puts "Game saved."
    exit
  end

  def load_game
    saved = YAML.safe_load(File.read('saved_game.yml'), 
    permitted_classes: [Symbol, Pawn, Rook, Bishop, Queen, King, Knight, Board], aliases: true)
    @board.board = saved[:board]
    turn = saved[:turn]
    @board.white_pieces = saved[:white_pieces]
    @board.black_pieces = saved[:black_pieces]
    @board.white_captured = saved[:white_captured]
    @board.black_captured = saved[:black_captured]
    @board.display_board
    turn
    #if turn == 1
      #@game.player_one_turn
    #else
      #@game.player_two_turn
    #end
  end
end