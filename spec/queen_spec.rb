require_relative '../lib/queen'
require 'colorize'

describe Queen do

  describe "#to_s" do
    
    context 'when player 1' do
    let(:game_board) { double('board') }
    subject(:queen_display) { described_class.new(1, 2, 2, game_board) }

      it 'returns white queen' do
        white_queen = " \u265B ".white
        white_display = queen_display.to_s
        expect(white_display).to eq(white_queen)
      end
    end

    context 'when player 2' do
    let(:game_board) { double('board') }
    subject(:queen_display) { described_class.new(2, 2, 2, game_board) }

      it 'returns black queen' do
        black_queen = " \u265B ".black
        black_display = queen_display.to_s
        expect(black_display).to eq(black_queen)
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

    context "when there are 3 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, false, true)
      end

      it 'sends highlight space to board four times' do
        expect(game_board).to receive(:highlight_space).exactly(4).times
        highlight_moves.move_up
      end
    end
  end

  describe "#move_down" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 1, 1, game_board) }

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

    context "when there are 2 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, true)
      end

      it 'sends highlight space to board three times' do
        expect(game_board).to receive(:highlight_space).exactly(3).times
        highlight_moves.move_down
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

    context "when there is 1 empty space in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, true)
      end

      it 'sends highlight space to board two times' do
        expect(game_board).to receive(:highlight_space).twice
        highlight_moves.move_right
      end
    end
  end

  describe "#move_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 8, game_board) }

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

    context "when there are 3 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, false, true)
      end

      it 'sends highlight space to board four times' do
        expect(game_board).to receive(:highlight_space).exactly(4).times
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

    context "when there are 3 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, false, true)
      end

      it 'sends highlight space to board four times' do
        expect(game_board).to receive(:highlight_space).exactly(4).times
        highlight_moves.move_up_right
      end
    end
  end

  describe "#move_up_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 1, 1, game_board) }

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

    context "when there are 2 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, true)
      end

      it 'sends highlight space to board three times' do
        expect(game_board).to receive(:highlight_space).exactly(3).times
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

    context "when there is 1 empty space in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, true)
      end

      it 'sends highlight space to board two times' do
        expect(game_board).to receive(:highlight_space).twice
        highlight_moves.move_down_right
      end
    end
  end

  describe "move_down_left" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 8, game_board) }

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

    context "when there are 3 empty spaces in front and then an opponent piece" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
        allow(game_board).to receive(:empty_space?).and_return(true, true, true, false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false, false, false, true)
      end

      it 'sends highlight space to board four times' do
        expect(game_board).to receive(:highlight_space).exactly(4).times
        highlight_moves.move_down_left
      end
    end
  end

  describe "#update_location" do
    
    let(:game_board) { double('board') }
    subject(:queen_update) { described_class.new(1, 2, 2, game_board) }

    before do
      queen_update.update_location(3, 2)
    end

    it 'updates row to 3' do
      row = queen_update.row
      expect(row).to eq(3)
    end
  end
end