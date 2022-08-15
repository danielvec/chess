require_relative '../lib/player'

describe Player do

  describe "#choose_piece" do

    subject(:piece_choice) { described_class.new("white") }

    context 'when user chooses a valid piece' do
      before do
        valid_piece = [7, 4]
        allow(piece_choice).to receive(:select_square).and_return(valid_piece)
      end

      it 'stops loop and does not display error message' do
        error_message = "Not a valid piece!"
        expect(piece_choice).not_to receive(:puts).with(error_message)
        piece_choice.choose_piece
      end
    end

    context 'when user chooses an invalid piece twice, then a valid piece' do
      before do
        invalid_piece = [2, 2]
        valid_piece = [7, 2]
        prompt = "Choose the piece you would like to move, letter then number, e.g., B2"
        allow(piece_choice).to receive(:puts).with(prompt)
        allow(piece_choice).to receive(:select_square).and_return(invalid_piece, invalid_piece, valid_piece)
      end

      it 'stops loop and displays error message twice' do
        error_message = "Not a valid piece!"
        expect(piece_choice).to receive(:puts).with(error_message).twice
        piece_choice.choose_piece
      end
    end
  end

  describe "#select_square" do

    subject(:player_input) { described_class.new("white") }

    context 'when user chooses a valid piece' do
      before do
        valid_input = "D2"
        allow(player_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        error_message = "Input Error!"
        expect(player_input).not_to receive(:puts).with(error_message)
        player_input.select_square
      end
    end

    context 'when user chooses an invalid value twice, then a valid value' do
      before do
        invalid_value = "27"
        valid_value = "G3"
        prompt = "Choose the piece you would like to move, letter then number, e.g., B2"
        allow(player_input).to receive(:puts).with(prompt)
        allow(player_input).to receive(:gets).and_return(invalid_value, invalid_value, valid_value)
      end

      it 'stops loop and displays error message twice' do
        error_message = "Input Error!"
        expect(player_input).to receive(:puts).with(error_message).twice
        player_input.select_square
      end
    end
  end

  describe "#validate_input" do

    subject(:input_validate) { described_class.new("white") }

    context 'when given a valid input' do
      it 'returns valid input' do
        valid_input = "B2"
        validated_input = input_validate.validate_input(valid_input)
        expect(validated_input).to eq("B2")
      end
    end

    context 'when given an invalid input' do
      it 'returns nil' do
        invalid_input = "J2"
        validated_input = input_validate.validate_input(invalid_input)
        expect(validated_input).to eq(nil)
      end
    end
  end
end