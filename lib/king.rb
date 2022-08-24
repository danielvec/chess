# represents a king chess piece
class King
    attr_reader :player, :board
    attr_accessor :row, :column, :previous_row, :previous_column
  
    def initialize(player, row, column, board)
      @player = player
      @row = row
      @column = column
      @board = board
      @previous_row = nil
      @previous_column = nil
    end
  
    def to_s
      if player == 1
        " \u265A ".white
      elsif player == 2
        " \u265A ".black
      end
    end
  
    def possible_moves
      move_up
      move_right
      move_down
      move_left
      move_up_right
      move_up_left
      move_down_right
      move_down_left
    end
  
    def move_up(new_row = row, new_column = column)
      if viable_move?(new_row - 1, new_column)
        board.highlight_space(new_row - 1, new_column)
      end  
    end
    
    def move_down(new_row = row, new_column = column)
      if viable_move?(new_row + 1, new_column)
        board.highlight_space(new_row + 1, new_column)
      end
    end
    
    def move_right(new_row = row, new_column = column)
      if viable_move?(new_row, new_column + 1)
        board.highlight_space(new_row, new_column + 1)
      end
    end
    
    def move_left(new_row = row, new_column = column)
      if viable_move?(new_row, new_column - 1)
        board.highlight_space(new_row, new_column - 1)
      end
    end
    
    def move_up_right(new_row = row, new_column = column)
      if viable_move?(new_row - 1, new_column + 1)
        board.highlight_space(new_row - 1, new_column + 1)
      end
    end
    
    def move_up_left(new_row = row, new_column = column)
      if viable_move?(new_row - 1, new_column - 1)
        board.highlight_space(new_row - 1, new_column - 1)
      end
    end
    
    def move_down_right(new_row = row, new_column = column)
      if viable_move?(new_row + 1, new_column + 1)
        board.highlight_space(new_row + 1, new_column + 1)
      end
    end
    
    def move_down_left(new_row = row, new_column = column)
      if viable_move?(new_row + 1, new_column - 1)
        board.highlight_space(new_row + 1, new_column - 1)
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
    
    private
  
    def viable_move?(row, column)
      board.valid_space?(row, column) &&
        (board.empty_space?(row, column) || opponent_piece?(row, column))
    end
  
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