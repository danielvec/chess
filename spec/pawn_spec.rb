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

  describe "#move_options" do

    let(:game_board) { double('board') }
    subject(:highlight_moves) { described_class.new(1, 2, 2, game_board) }

    context "when it's the pawn's first move" do
      before do
        allow(game_board).to receive(:empty_space?).and_return(true)
      end

      it 'sends highlight space to board twice' do
        expect(game_board).to receive(:highlight_space).twice
        highlight_moves.move_options(1)
      end
    end

    context "when it's the pawn's second move" do
      before do
        highlight_moves.move_count = 1
        allow(game_board).to receive(:empty_space?).and_return(true)
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_moves.move_options(1)
      end
    end

    context "when it's the pawn's second move and space in front is empty" do
      before do
        highlight_moves.move_count = 1
        allow(game_board).to receive(:empty_space?).and_return(false)
      end

      it 'does not send highlight space to board' do
        expect(game_board).not_to receive(:highlight_space)
        highlight_moves.move_options(1)
      end
    end
  end

  describe "#capture_left" do

    let(:game_board) { double('board') }
    subject(:highlight_captures) { described_class.new(1, 7, 2, game_board) }

    context "when there is an opponent piece one space forward diagonal left" do
      before do
        allow(game_board).to receive(:piece_color).with(6, 1).and_return("black")
      end

      it 'sends highlight space to board once' do
        expect(game_board).to receive(:highlight_space).once
        highlight_captures.capture_left(-1)
      end
    end
  end

  describe "#capture_right" do

    let(:game_board) { double('board') }
    subject(:highlight_captures) { described_class.new(1, 7, 2, game_board) }

    context "when there is one opponent piece one space forward diagonal right" do
      before do
        allow(game_board).to receive(:piece_color).with(6, 3).and_return("black")
      end

      it 'sends highlight space to board twice' do
        expect(game_board).to receive(:highlight_space).once
        highlight_captures.capture_right(-1)
      end
    end
  end

  describe "#previous_location" do
    
    let(:game_board) { double('board') }
    subject(:pawn_previous) { described_class.new(1, 2, 2, game_board) }

    before do
      pawn_previous.previous_location(2, 3)
    end

    it 'updates column to 3' do
      column = pawn_previous.previous_column
      expect(column).to eq(3)
    end
  end

  describe "#adjust_move_count" do

    let(:game_board) { double('board') }
    subject(:adjust_moves) { described_class.new(1, 2, 2, game_board) }

    before do
      adjust_moves.move_count = 3
      change = -2
      adjust_moves.adjust_move_count(change)
    end

    it 'adjusts moves to 1' do
      moves = adjust_moves.move_count
      expect(moves).to eq(1)
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

  describe "#deactivate" do

    let(:game_board) { double('board') }
    subject(:pawn_deactive) { described_class.new(1, 2, 2, game_board) }

    before do
      pawn_deactive.deactivate
    end

    it 'changes active to false' do
      active = pawn_deactive.active
      expect(active).to be false
    end
  end
end