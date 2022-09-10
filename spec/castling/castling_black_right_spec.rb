require_relative '../../lib/castling/castling'
require_relative '../../lib/castling/castling_black_right'
require_relative 'castling_shared_spec'

describe CastlingBlackRight do

  context 'when castling is valid' do
    include_examples '#castle'
    include_examples '#empty_spaces'
    include_examples '#castle_check?'
    include_examples '#moves'
  end

end