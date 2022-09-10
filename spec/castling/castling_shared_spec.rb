RSpec.shared_examples '#castle' do

  let(:game_board) { double( 'board' ) }
  subject(:castle_move) { described_class.new(game_board) }

  before do
    allow(castle_move).to receive(:king)
    allow(castle_move).to receive(:rook)
    allow(castle_move).to receive(:moves).and_return(0).twice
    allow(castle_move).to receive(:empty_spaces?).and_return(true)
    allow(castle_move).to receive(:castle_check?).and_return(false)
    allow(game_board).to receive(:color_board)
  end

  it 'sends highlight_space to board' do
    expect(game_board).to receive(:highlight_space)
    castle_move.castle
  end
end

RSpec.shared_examples '#empty_spaces' do

  let(:game_board) { double( 'board' ) }
  subject(:castle_spaces) { described_class.new(game_board) }

  before do
    allow(game_board).to receive(:empty_space?).and_return(true, true, true)
  end

  it 'is empty spaces' do
    expect(castle_spaces).to be_empty_spaces
    castle_spaces
  end
end

RSpec.shared_examples '#castle_check?' do

  let(:game_board) { double( 'board' ) }
  subject(:castle_check) { described_class.new(game_board) }

  before do
    allow(game_board).to receive(:valid_move?).and_return(true, true, true)
  end

  it 'is castle check' do
    expect(castle_check).to be_castle_check
    castle_check
  end
end

RSpec.shared_examples '#moves' do

  let(:game_board) { double( 'board' ) }
  let(:piece) { double( 'piece' ) }
  subject(:castle_check) { described_class.new(game_board) }

  it 'sends move_count to piece' do
    expect(piece).to receive(:move_count)
    castle_check.moves(piece)
  end
end