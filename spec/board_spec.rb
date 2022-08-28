require_relative '../lib/board'

describe Board do

  describe '#color_board' do
    subject(:board_color) { described_class.new }

    it 'sends on_blue to first square' do
      first_square = board_color.board[1][1]
      expect(first_square).to receive(:on_blue)
      board_color.color_board
    end

    it 'returns a blue first square in third row' do
      blue = "\e[0;39;44m   \e[0m"
      board_color.color_board
      first_square = board_color.board[3][1]
      expect(first_square).to eq(blue)
    end

    it 'sends on_light_blue to fifth row, fourth column' do
      middle_square = board_color.board[5][4]
      expect(middle_square).to receive(:on_light_blue)
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

  describe '#add_rooks' do
    subject(:rook_add) { described_class.new }

    it 'creates 4 new Rooks' do
      expect(Rook).to receive(:new).exactly(4).times
      rook_add
    end
  end

  describe '#add_bishops' do
    subject(:bishop_add) { described_class.new }

    it 'creates 4 new Bishops' do
      expect(Bishop).to receive(:new).exactly(4).times
      bishop_add
    end
  end

  describe '#add_knights' do
    subject(:knight_add) { described_class.new }

    it 'creates 4 new Knights' do
      expect(Rook).to receive(:new).exactly(4).times
      knight_add
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

  describe '#highlight_space' do
    subject(:space_highlight) { described_class.new }
  
    it 'sends on_red to fifth row, fourth column' do
      middle_square = space_highlight.board[5][4]
      expect(middle_square).to receive(:on_red)
      space_highlight.highlight_space(5, 4)
    end

    it 'returns a red square' do
      red = "\e[0;39;41m   \e[0m"
      space_highlight.highlight_space(5, 4)
      middle_square = space_highlight.board[5][4]
      expect(middle_square).to eq(red)
    end
  end

  describe '#selected_piece' do
    subject(:piece_select) { described_class.new }
  
    it 'returns the last white pawn in the 7th row' do
      white_pieces = piece_select.instance_variable_get(:@white_pieces)
      pawn_seven = piece_select.selected_piece(1, 7, 8)
      expect(pawn_seven).to eq(white_pieces[7])
    end
  end

  describe '#valid_move?' do
    subject(:move_valid) { described_class.new }
  
    context 'when space is highlighted' do
      before do
        move_valid.highlight_space(4, 4)
      end

      it 'is valid move' do
        expect(move_valid).to be_valid_move(4, 4)
      end
    end

    context 'when space is not highlighted' do
      it 'is not valid move' do
        expect(move_valid).to_not be_valid_move(4, 4)
      end
    end
  end 

  describe '#move_piece' do
    subject(:piece_move) { described_class.new }
    let(:white_pawn) { double('pawn', row: 7, column: 4) }
  
    before do
      row = 6
      column = 4
      allow(white_pawn).to receive(:previous_location)
      allow(white_pawn).to receive(:update_location).with(row, column)
      piece_move.move_piece(white_pawn, row, column)
    end

    it "change's pawn's space to blank" do
      expect(piece_move.board[7][4]).to eq("   ")
    end

    it 'adds pawn to new space' do
      expect(piece_move.board[6][4]).to eq("#{white_pawn}")
    end
  end

  describe '#undo_move' do
    subject(:move_undo) { described_class.new }
    let(:white_pawn) { double('pawn', row: 6, column: 4, moves: 1) }
  
    before do
      allow(white_pawn).to receive(:previous_row)
      allow(white_pawn).to receive(:previous_column)
      allow(move_undo).to receive(:move_piece)
    end

    it "sends adjust_move_count to piece" do
      expect(white_pawn).to receive(:adjust_move_count).with(-2).once
      move_undo.undo_move(white_pawn)
    end
  end

  describe '#add_captured' do
    subject(:captures) { described_class.new }

    context 'when a black pawn is captured' do
      it 'sends a pawn to black_captured' do
        pawn = "\u265F"
        captures.add_captured(2, 2)
        expect(captures.black_captured[0]).to eq(pawn)
      end
    end
  end

  describe '#valid_space?' do
    subject(:space_valid) { described_class.new }

    context 'when row and column are between 1 and 8' do
      it 'is valid space' do
        row = 4
        column = 4
        expect(space_valid).to be_valid_space(row, column)
      end
    end

    context 'when row and column are not between 1 and 8' do
      it 'is not valid space' do
        row = 0
        column = 10
        expect(space_valid).to_not be_valid_space(row, column)
      end
    end
  end

  describe '#empty_space?' do
    subject(:vacant_space) { described_class.new }
  
    context 'when in the middle of board at game beginning' do
      it 'is empty space' do
        row = 4
        column = 4
        expect(vacant_space).to be_empty_space(row, column)
      end
    end

    context 'when pawn is in space' do
      it 'is not empty move' do
        row = 2
        column = 2
        expect(vacant_space).to_not be_empty_space(row, column)
      end
    end
  end

  describe '#highlight_black_moves' do
    subject(:moves_highlight) { described_class.new }
  
    it 'sends possible_moves to first black piece' do
      black_pieces = moves_highlight.instance_variable_get(:@black_pieces)
      expect(black_pieces[0]).to receive(:possible_moves).once
      moves_highlight.highlight_black_moves
    end

    it 'sends possible_moves to last black piece' do
      black_pieces = moves_highlight.instance_variable_get(:@black_pieces)
      expect(black_pieces[15]).to receive(:possible_moves).once
      moves_highlight.highlight_black_moves
    end
  end 

  describe '#highlight_white_moves' do
    subject(:moves_highlight) { described_class.new }
  
    it 'sends possible_moves to first white piece' do
      white_pieces = moves_highlight.instance_variable_get(:@white_pieces)
      expect(white_pieces[0]).to receive(:possible_moves).once
      moves_highlight.highlight_white_moves
    end

    it 'sends possible_moves to last white piece' do
      white_pieces = moves_highlight.instance_variable_get(:@white_pieces)
      expect(white_pieces[15]).to receive(:possible_moves).once
      moves_highlight.highlight_white_moves
    end
  end 
end