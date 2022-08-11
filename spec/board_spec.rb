require_relative '../lib/board'

describe Board do

  describe '#color_board' do
    subject(:board_color) { described_class.new }

    it 'sends on_blue to first square' do
      first_square = board_color.board[1][1]
      expect(first_square).to receive(:on_blue)
      board_color.color_board
    end

    it 'returns a blue first square' do
      blue = "\e[0;39;44m   \e[0m"
      board_color.color_board
      first_square = board_color.board[1][1]
      expect(first_square).to eq(blue)
    end

    it 'sends on_white to fifth row, fourth column' do
      middle_square = board_color.board[5][4]
      expect(middle_square).to receive(:on_white)
      board_color.color_board
    end
  end

  describe '#add_pawns' do
    subject(:pawn_add) { described_class.new }

    it 'creates 16 new Pawns' do
      expect(Pawn).to receive(:new).exactly(16).times
      pawn_add
    end
  end

  describe '#piece_color' do
    subject(:color_piece) { described_class.new }

    context 'at the beginning of the game' do
      it 'returns black for 2nd row pieces' do
        black_pawn = color_piece.piece_color(2, 2)
        expect(black_pawn).to eq("black")
      end

      it 'returns white for 7th row pieces' do
        white_pawn = color_piece.piece_color(7, 4)
        expect(white_pawn).to eq("white")
      end

      it 'does not return white or black for blank spaces' do
        no_piece = color_piece.piece_color(5, 2)
        expect(no_piece).to_not eq("black")
        expect(no_piece).to_not eq("white")
      end
    end
  end
end