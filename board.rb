require_relative 'pieces'
require_relative 'display'

class Board
  attr_reader :grid, :display
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

    raise MoveError.new("You didn't select a piece!") if self[start_pos].nil?
    raise MoveError.new("Invalid move for that piece!") unless self[start_pos].moves.include?(end_pos)

    if self[start_pos].move_into_check?(end_pos)
      raise MoveError.new("That will put you in check!")
    else
      move!(start_pos, end_pos)
    end

  end

  def move!(start_pos, end_pos)
    self[start_pos], self[end_pos] = nil, self[start_pos]
    piece = self[end_pos]
    piece.position = end_pos
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
    get_pieces_of(color).each do |piece|
      king = piece if piece.class == King
    end
    other_color = (color == :black ? :white : :black)
    get_pieces_of(other_color).each do |piece|
      return true if piece.moves.include?(king.position)
    end
    false
  end

  def get_pieces_of (color)
    pieces = []
    grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        pieces << piece if piece.color == color
      end
    end
    pieces
  end


  def checkmate?(color)
    return false unless in_check?(color)
    pieces = get_pieces_of(color)
    pieces.all? do |piece|
      piece.moves.all? do |move|
        piece.move_into_check?(move)
      end
    end
  end

  def dup
    new_board = Board.new(false)
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        if piece.class == Pawn
          Pawn.new(new_board, piece.position.dup, piece.color, piece.moved)
        else
          piece.class.new(new_board, piece.position.dup, piece.color)
        end
      end
    end
    new_board
  end

  # def self.check_scenario()
  #   b = Board.new(false)
  #   b[[0,0]] = King.new(b, [0, 0], :white)
  #   b[[2,0]] = Queen.new(b, [2,0], :black)
  #   b[[2,1]] = Queen.new(b, [2,1], :black)
  #   b.checkmate?(:white)
  # end
  def inspect
    self.object_id
  end

end

class MoveError < RuntimeError
end



if __FILE__ == $0
  b = Board.new
  display = Display.new(b)
  display.get_move
end
