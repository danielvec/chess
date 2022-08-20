# represents a bishop chess piece
class Bishop
    attr_reader :player, :board
    attr_accessor :row, :column
    
    def initialize(player, row, column, board)
      @player = player
      @row = row
      @column = column
      @board = board
    end
  
    def to_s
      if player == 1
        " \u265D ".white
      elsif player == 2
        " \u265D ".black
      end
    end
  
    def possible_moves
      move_up_right
      move_up_left
      move_down_right
      move_down_left
    end
  
    def move_up_right(new_row = row, new_column = column)
      if board.empty_space?(new_row - 1, new_column + 1) || opponent_piece?(new_row - 1, new_column + 1)
        board.highlight_space(new_row - 1, new_column + 1)
        move_up_right(new_row - 1, new_column + 1) unless opponent_piece?(new_row - 1, new_column + 1)
      end
    end
  
    def move_up_left(new_row = row, new_column = column)
      if board.empty_space?(new_row - 1, new_column - 1) || opponent_piece?(new_row - 1, new_column - 1)
        board.highlight_space(new_row - 1, new_column - 1)
        move_up_left(new_row - 1, new_column - 1) unless opponent_piece?(new_row - 1, new_column - 1)
      end
    end
  
    def move_down_right(new_row = row, new_column = column)
      if board.empty_space?(new_row + 1, new_column + 1) || opponent_piece?(new_row + 1, new_column + 1)
        board.highlight_space(new_row + 1, new_column + 1)
        move_down_right(new_row + 1, new_column + 1) unless opponent_piece?(new_row + 1, new_column + 1)
      end
    end
  
    def move_down_left(new_row = row, new_column = column)
      if board.empty_space?(new_row + 1, new_column - 1) || opponent_piece?(new_row + 1, new_column - 1)
        board.highlight_space(new_row + 1, new_column - 1)
        move_down_left(new_row + 1, new_column - 1) unless opponent_piece?(new_row + 1, new_column - 1)
      end
    end
  
    def update_location(new_row, new_column)
      self.row = new_row
      self.column = new_column
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