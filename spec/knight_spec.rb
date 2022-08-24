require_relative '../lib/knight'
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

  describe "#move" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 8, 2, game_board) }

    context "when the game begins" do
      before do
        allow(game_board).to receive(:valid_space?).and_return(true)
      end

      it 'sends highlight space to board to move [-2, 1]' do
        row_direction = -2
        column_direction = 1
        allow(game_board).to receive(:empty_space?).and_return(true)
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move(row_direction, column_direction)
      end

      it 'does not send highlight space to board to move [2, 1]' do
        row_direction = 2
        column_direction = 1
        allow(game_board).to receive(:empty_space?).and_return(false)
        allow(highlight_moves).to receive(:opponent_piece?).and_return(false)
        expect(game_board).to_not receive(:highlight_space)
        highlight_moves.move(row_direction, column_direction)
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
end