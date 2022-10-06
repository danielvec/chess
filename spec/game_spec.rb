require_relative '../lib/game'
require_relative '../lib/board'

describe Game do

  describe '#white_check?' do
    subject(:check) { described_class.new }
    let(:game_board) { instance_double(Board) }

    context 'when game begins' do
      it 'is not white_check' do
        allow(game_board).to receive(:highlight_black_moves)
        expect(check).not_to be_white_check
        check
      end
    end

    context 'when in check' do

      before do
        check.white_king.row = 3
        check.white_king.column = 2
      end

      it 'is not white_check' do
        allow(game_board).to receive(:highlight_black_moves)
        expect(check).to be_white_check
        check
      end
    end    
  end

  describe '#black_check?' do
    subject(:check) { described_class.new }
    let(:game_board) { instance_double(Board) }

    context 'when game begins' do
      it 'is not black_check' do
        allow(game_board).to receive(:highlight_white_moves)
        expect(check).not_to be_black_check
        check
      end
    end

    context 'when in check' do

      before do
        check.black_king.row = 6
        check.black_king.column = 2
      end
      
      it 'is not black_check' do
        allow(game_board).to receive(:highlight_white_moves)
        expect(check).to be_black_check
        check
      end
    end    
  end

  describe '#piece_selection' do
    subject(:select_piece) { described_class.new }
    let(:game_board) { instance_double(Board) }
    let(:user) { instance_double(Player) }

    context 'when chosen piece is [8, 5]' do
      it 'returns white king' do
        white_king = " \u265A ".white
        chosen_piece = [8, 5]
        allow(game_board).to receive(:color_board)
        allow(user).to receive(:choose_piece).and_return(chosen_piece)
        king = select_piece.piece_selection(user, 1)
        expect(king.to_s).to eq(white_king)
      end
    end  
  end

  describe '#display_moves' do
    let(:game_board) { instance_double(Board) }
    let(:piece) { instance_double(Queen) }
    let(:king) { instance_double(King) }
    subject(:move_display) { described_class.new(game_board) }

    before do
      allow(move_display).to receive(:castling_moves)
      allow(move_display).to receive(:invalidate_moves)
      allow(move_display).to receive(:white_king)
    end

    it 'sends possible_move to selected piece' do
      allow(game_board).to receive(:display_board)
      expect(piece).to receive(:possible_moves)
      move_display.display_moves(piece, 1)
    end

    it 'sends display_board to board' do
      allow(piece).to receive(:possible_moves)
      expect(game_board).to receive(:display_board)
      move_display.display_moves(piece, 1)
    end
  end

  describe '#move_selection' do
    let(:game_board) { instance_double(Board) }
    let(:user) { instance_double(Player) }
    let(:piece) { instance_double(King) }
    subject(:select_move) { described_class.new(game_board, user) }

    it 'sends move_piece to player' do
      chosen_space = [8, 5]
      expect(user).to receive(:move_piece).and_return(chosen_space)
      allow(game_board).to receive(:move_piece).with(piece, chosen_space[0], chosen_space[1])
      select_move.move_selection(user, piece, 1)
    end

    it 'sends move_piece to board' do
      chosen_space = [8, 5]
      allow(user).to receive(:move_piece).and_return(chosen_space)
      expect(game_board).to receive(:move_piece)
      select_move.move_selection(user, piece, 1)
    end
  end
end