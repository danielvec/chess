class Piece
  attr_reader :player, :board
  attr_accessor :row, :column, :previous_row, :previous_column, :active
  alias_method :active?, :active

  def initialize(player, row, column, board)
    @player = player
    @row = row
    @column = column
    @board = board
    @previous_row = nil
    @previous_column = nil
    @active = true
  end

  def to_s
    if player == 1
      symbol.white
    elsif player == 2
      symbol.black
    end
  end

  def previous_location(row, column)
    self.previous_row = row
    self.previous_column = column
  end
  
  def update_location(new_row, new_column)
    self.row = new_row
    self.column = new_column
  end

  def deactivate
    self.active = false
    self.row = nil
    self.column = nil
  end

  def activate(row, column)
    self.active = true
    self.row = row
    self.column = column
  end
  
  private

  def opponent_piece?(row, column)
    board.piece_color(row, column) == opponent_color
  end

  def opponent_color
    if player == 1
      "black"
    elsif player == 2
      "white"
    end
  end
end