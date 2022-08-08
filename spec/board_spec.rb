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
end