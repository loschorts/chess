require_relative 'pieces'
require_relative 'display'

class Board
  attr_reader :grid
  def initialize new_game = true
    @grid = Array.new(8) { Array.new(8) }
    populate if new_game
    @display = Display.new(self)
  end

  def rows
    @grid
  end

  def get_move
    start_pos = @display.get_player_input
    end_pos = @display.get_player_input
    [start_pos, end_pos]
  end

  def populate


    [:black, :white].each do |color|
      back_row = (color == :black ?  0 : 7)
      back_line = [
      Rook.new(self, [back_row,0], color),
      Knight.new(self, [back_row,1], color),
      Bishop.new(self, [back_row,2], color),
      Queen.new(self, [back_row,3], color),
      King.new(self, [back_row,4], color),
      Bishop.new(self, [back_row,5], color),
      Knight.new(self, [back_row,6], color),
      Rook.new(self, [back_row,7], color)
      ]
      pawn_row = (color == :black ? 1 : 6)
      pawn_line = []
      8.times do |col|
        pawn_line << Pawn.new(self, [pawn_row, col], color)
      end
      @grid[back_row] = back_line
      @grid[pawn_row] = pawn_line
    end

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def move(start_pos, end_pos)
    unless on_board?(start_pos) && on_board?(end_pos)
      raise RuntimeError.new("Come on, bro...")
    end
    raise RuntimeError.new("You didn't select a piece!") if self[start_pos].nil?
    #unless self[start_pos].valid_moves.include?(end_pos)
    #  raise RuntimeError.new("Invalid move for that piece!")
    #end

    self[start_pos], self[end_pos] = nil, self[start_pos]
  end

  def in_bounds?(pos)
    pos.all? {|x| (0...8).include?(x)}
  end

  def line_type(start_pos, end_pos)
    start_row, start_column = start_pos
    end_row, end_column = end_pos

    if start_row == end_row
      pieces_between = @grid[start_row][start_column+1...end_column]
    end

    return :vertical if start_column == end_column
    return :diagonal if

    pieces_between.all? {|piece| piece.nil? || !piece.friendly?}
  end

  def in_check?(color)
    king = nil
    grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        if piece.class == King && piece.color == color
          king = piece
        end
      end
    end
    grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        return true if piece.color != king.color && piece.moves.include?(king.position)
      end
    end
    false
  end


  def to_s
    result = ""
    @grid.each do |row|
      row.each do |el|
        if el.nil?
          result << "_"
        else
          result << el.to_s
        end
      end
      result << "\n"
    end
    result
  end

  def self.check_scenario()
    b = Board.new(false)
    b[[4,4]] = King.new(b, [4, 4], :white)
    b[[5,5]] = Queen.new(b, [1,2], :black)
    b.in_check?(:white)
  end

end



if __FILE__ == $0
  p Board.check_scenario
end
