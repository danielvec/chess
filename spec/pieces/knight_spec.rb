require_relative '../../lib/pieces/knight'
require 'colorize'

describe Knight do

  describe "#to_s" do
    
    context 'when player 1' do
    let(:game_board) { double('board') }
    subject(:knight_display) { described_class.new(1, 2, 2, game_board) }

      it 'returns white knight' do
        white_knight = " \u265E ".white
        white_display = knight_display.to_s
        expect(white_display).to eq(white_knight)
      end
    end

    context 'when player 2' do
    let(:game_board) { double('board') }
    subject(:knight_display) { described_class.new(2, 2, 2, game_board) }

      it 'returns black knight' do
        black_knight = " \u265E ".black
        black_display = knight_display.to_s
        expect(black_display).to eq(black_knight)
      end
    end
  end

  describe "up_up_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.up_up_right
      end
    end
  end

  describe "#up_up_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.up_up_left
      end
    end
  end

  describe "#down_down_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(false)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.down_down_right
      end
    end
  end

  describe "#down_down_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(false)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.down_down_left
      end
    end
  end

  describe "#up_right_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.up_right_right
      end
    end
  end

  describe "#up_left_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(false)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.up_left_left
      end
    end
  end

  describe "#down_right_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(false)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.down_right_right
      end
    end
  end

  describe "#down_left_left" do
  
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(false)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.down_left_left
      end
    end
  end

  describe "#previous_location" do
    
    let(:game_board) { double('board') }
    subject(:knight_previous) { described_class.new(1, 2, 2, game_board) }

    before do
      knight_previous.previous_location(2, 3)
    end

    it 'updates column to 3' do
      column = knight_previous.previous_column
      expect(column).to eq(3)
    end
  end

  describe "#update_location" do
    
    let(:game_board) { double('board') }
    subject(:knight_update) { described_class.new(1, 2, 2, game_board) }

    before do
      knight_update.update_location(3, 2)
    end

    it 'updates row to 3' do
      row = knight_update.row
      expect(row).to eq(3)
    end
  end

  describe "#deactivate" do

    let(:game_board) { double('board') }
    subject(:knight_deactive) { described_class.new(1, 2, 2, game_board) }

    before do
      knight_deactive.deactivate
    end

    it 'changes active to false' do
      active = knight_deactive.active
      expect(active).to be false
    end
  end
end