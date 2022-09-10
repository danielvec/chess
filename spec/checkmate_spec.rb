require_relative '../lib/checkmate'
require_relative '../lib/board'

describe Checkmate do

  describe '#attack_king_attacker?' do
    let(:game_board) { instance_double(Board) }
    let(:attacker) { instance_double(Rook) }
    let(:king) { instance_double(King) }
    subject(:end_game) { described_class.new(attacker, king, 1, game_board) }

    before do
      allow(attacker).to receive(:row).and_return(7)
      allow(attacker).to receive(:column).and_return(5)
      allow(game_board).to receive(:color_board)
      allow(end_game).to receive(:potential_moves)
      allow(game_board).to receive(:valid_move?)
    end

    it 'sends color_board to board' do
      expect(game_board).to receive(:color_board)
      end_game.attack_king_attacker?
    end

    it 'sends valid_move to board with attacker row and column' do
      expect(game_board).to receive(:valid_move?).with(7, 5)
      end_game.attack_king_attacker?
    end
  end

  describe 'block_attacker?' do
    let(:game_board) { instance_double(Board) }
    let(:attacker) { instance_double(Rook) }
    let(:king) { instance_double(King) }
    subject(:end_game) { described_class.new(attacker, king, 1, game_board) }

    before do
      allow(end_game).to receive(:path_to_king)
      allow(end_game).to receive(:highlighted_spaces)
      allow(game_board).to receive(:color_board)
      allow(end_game).to receive(:potential_moves).with(15)
    end

    context 'when player can block attacker' do
      it 'is block attacker' do
        player_moves = [[4, 4], [5, 4]]
        opponent_path = [[4, 4], [5, 5]]
        allow(end_game).to receive(:highlighted_spaces).and_return(opponent_path, player_moves)
        expect(end_game).to be_block_attacker
        end_game.block_attacker?
      end
    end

    context 'when player cannot block attacker' do
      it 'is not block attacker ' do
        player_moves = [[4, 4], [5, 4]]
        opponent_path = [[3, 5], [3, 4]]
        allow(end_game).to receive(:highlighted_spaces).and_return(opponent_path, player_moves)
        expect(end_game).to_not be_block_attacker
        end_game.block_attacker?
      end
    end
  end

  describe 'move_king?' do
    let(:game_board) { instance_double(Board) }
    let(:attacker) { instance_double(Rook) }
    let(:king) { instance_double(King) }
    subject(:end_game) { described_class.new(attacker, king, 1, game_board) }

    context 'when king can move out of check' do
      it 'is move king' do
        king_moves = [[4, 4], [5, 4]]
        opponent_moves = [[4, 4], [5, 5]]
        allow(end_game).to receive(:king_moves).and_return(king_moves)
        allow(end_game).to receive(:opponent_moves).and_return(opponent_moves)
        expect(end_game).to be_move_king
        end_game.move_king?
      end
    end

    context 'when king cannot move out of check' do
      it 'is not move king' do
        king_moves = [[4, 4], [5, 4]]
        opponent_moves = [[4, 4], [5, 4]]
        allow(end_game).to receive(:king_moves).and_return(king_moves)
        allow(end_game).to receive(:opponent_moves).and_return(opponent_moves)
        expect(end_game).to_not be_move_king
        end_game.move_king?
      end
    end
  end
end