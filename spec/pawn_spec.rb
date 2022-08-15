require_relative '../lib/pawn'
require 'colorize'

describe Pawn do

  describe "#to_s" do
    
    context 'when player 1' do
    let(:game_board) { double('board') }
    subject(:pawn_display) { described_class.new(1, 2, 2, game_board) }

      it 'returns white pawn' do
        white_pawn = " \u265F ".white
        white_display = pawn_display.to_s
        expect(white_display).to eq(white_pawn)
      end
    end

    context 'when player 2' do
    let(:game_board) { double('board') }
    subject(:pawn_display) { described_class.new(2, 2, 2, game_board) }

      it 'returns black pawn' do
        black_pawn = " \u265F ".black
        black_display = pawn_display.to_s
        expect(black_display).to eq(black_pawn)
      end
    end
  end

  describe "#highlight_options" do
    
    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 2, 2, game_board) }

    context "when it's the pawn's first move" do
      before do
        allow(game_board).to receive(:empty_space?).and_return(true)
      end

      it 'sends highlight space to board twice' do
        expect(game_board).to receive(:highlight_space).twice
        highlight_moves.highlight_options(1)
      end
    end

    context "when it's the pawn's second move" do
      before do
        highlight_moves.moves = 1
        allow(game_board).to receive(:empty_space?).and_return(true)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.highlight_options(1)
      end
    end

    context "when it's the pawn's second move and space in front is empty" do
      before do
        highlight_moves.moves = 1
        allow(game_board).to receive(:empty_space?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).not_to receive(:highlight_space)
        highlight_moves.highlight_options(1)
      end
    end
  end

  describe "#update_location" do
    
    let(:game_board) { double('board') }
    subject(:pawn_update) { described_class.new(1, 2, 2, game_board) }

    before do
      pawn_update.update_location(3, 2)
    end

    it 'updates row to 3' do
      row = pawn_update.row
      expect(row).to eq(3)
    end
  end
end