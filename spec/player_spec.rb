require_relative '../lib/player'

describe Player do

  describe "#choose_piece" do

    subject(:player_input) { described_class.new("white") }

    context 'when user chooses a valid piece' do
      before do
        valid_input = "D2"
        allow(player_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        error_message = "Input Error!"
        expect(player_input).not_to receive(:puts).with(error_message)
        player_input.choose_piece
      end
    end

    context 'when user chooses an invalid piece, then an invalid value, then a valid piece' do
      before do
        invalid_piece = "A7"
        invalid_value = "27"
        valid_piece = "E2"
        prompt = "Choose the piece you would like to move, letter then number, e.g., B2"
        allow(player_input).to receive(:puts).with(prompt)
        allow(player_input).to receive(:gets).and_return(invalid_piece, invalid_value, valid_piece)
      end

      it 'stops loop and displays error message twice' do
        error_message = "Input Error!"
        expect(player_input).to receive(:puts).with(error_message).twice
        player_input.choose_piece
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