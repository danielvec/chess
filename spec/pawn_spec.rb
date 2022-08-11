require_relative '../lib/pawn'
require 'colorize'

describe Pawn do

  describe "#to_s" do
    
    context 'when player 1' do
    subject(:pawn_display) { described_class.new(1, 2, 2) }

      it 'returns white pawn' do
        white_pawn = " \u265F ".white
        white_display = pawn_display.to_s
        expect(white_display).to eq(white_pawn)
      end
    end

    context 'when player 2' do
    subject(:pawn_display) { described_class.new(2, 2, 2) }

      it 'returns black pawn' do
        black_pawn = " \u265F ".black
        black_display = pawn_display.to_s
        expect(black_display).to eq(black_pawn)
      end
    end
  end
end