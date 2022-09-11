require_relative '../../lib/pieces/king'
require 'colorize'

describe King do

  describe "#to_s" do
    
    context 'when player 1' do
    let(:game_board) { double('board') }
    subject(:king_display) { described_class.new(1, 2, 2, game_board) }

      it 'returns white king' do
        white_king = " \u265A ".white
        white_display = king_display.to_s
        expect(white_display).to eq(white_king)
      end
    end

    context 'when player 2' do
    let(:game_board) { double('board') }
    subject(:king_display) { described_class.new(2, 2, 2, game_board) }

      it 'returns black king' do
        black_king = " \u265A ".black
        black_display = king_display.to_s
        expect(black_display).to eq(black_king)
      end
    end
  end

  describe "#move_up" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_up
      end
    end

    context "when there is an empty space in front" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_up
      end
    end
  end

  describe "#move_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_right
      end
    end

    context "when there is an empty space to the right" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_right
      end
    end
  end
  describe "#move_down" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_down
      end
    end

    context "when there is an empty space in back" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_down
      end
    end
  end

  describe "#move_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_left
      end
    end

    context "when there is an empty space to the left" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_left
      end
    end
  end

  describe "#move_up_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_up_right
      end
    end

    context "when there is an empty space up to the right" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_up_right
      end
    end
  end

  describe "#move_up_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_up_left
      end
    end

    context "when there is an empty space up to the left" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_up_left
      end
    end
  end
  describe "#move_down_right" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move_down_right
      end
    end

    context "when there is an empty space down to the right" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_down_right
      end
    end

    describe "#move_down_left" do
    
        let(:game_board) { double('board') }
        subject(:highlight_moves) { described_class.new(1, 8, 1, game_board) }
    
        context "when the game begins" do
          before do
            allow(game_board).to receive(:valid_space?).and_return(true)
            allow(game_board).to receive(:empty_space?).and_return(false)
            allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
          end
    
          it 'does not send highlight space to board' do
            expect(game_board).to_not receive(:highlight_space)
            highlight_moves.move_down_left
          end
        end
    
        context "when there is an empty space down to the left" do
          before do
            allow(game_board).to receive(:valid_space?).and_return(true)
            allow(game_board).to receive(:empty_space?).and_return(true)
            allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
          end
    
          it 'sends highlight space to board once' do
            expect(game_board).to receive(:highlight_space).once
            highlight_moves.move_down_left
          end
        end
      end
  end

  describe "#previous_location" do
    
    let(:game_board) { double('board') }
    subject(:king_previous) { described_class.new(1, 2, 2, game_board) }

    before do
      king_previous.previous_location(2, 3)
    end

    it 'updates column to 3' do
      column = king_previous.previous_column
      expect(column).to eq(3)
    end
  end

  describe "#update_location" do
    
    let(:game_board) { double('board') }
    subject(:king_update) { described_class.new(1, 2, 2, game_board) }

    before do
      king_update.update_location(3, 2)
    end

    it 'updates row to 3' do
      row = king_update.row
      expect(row).to eq(3)
    end
  end

  describe "#deactivate" do

    let(:game_board) { double('board') }
    subject(:king_deactive) { described_class.new(1, 2, 2, game_board) }

    before do
      king_deactive.deactivate
    end

    it 'changes active to false' do
      active = king_deactive.active
      expect(active).to be false
    end
  end
end