require_relative 'pieces'
require_relative 'display'

class Board
  class MoveError < RuntimeError
  end
  attr_reader :grid, :display

  def self.simple_checkmate
    board = self.new(false)
    King.new(board, [0,0], :white)
    King.new(board, [7,7], :black)
    Rook.new(board, [2,0], :black)
    Rook.new(board, [2,1], :black)
    board
  end
  def self.real_checkmate
    board = self.new
    board.move [6, 5], [5, 5]
    board.move [1, 4], [3, 4]
    board.move [6, 6], [4, 6]
    board.move [0, 3], [4, 7]
    board
  end

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

    raise MoveError.new("Empty") if self[start_pos].nil?
    raise MoveError.new("Impossible move") unless self[start_pos].possible_moves.include?(end_pos)

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

  def in_check?(color)
    king = get_king(color)
    pieces_of(other_color).any? do |piece|
      piece.allowed_moves.include?(king.position)
    end
  end

  def other_color color
    color == :black ? :white : :black
  end

  def get_king color
    pieces_of(color).each do |piece|
      return piece if piece.is_a? King
    end
    nil
  end

  def pieces_of (color)
    pieces = []
    grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  def get_moves_of color
    pieces = pieces_of color
    pieces.map {|p| p.valid_moves}
  end

  def checkmate?(color)
    return false unless in_check?(color)
    pieces = pieces_of(color)
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
    Display.new(self).render
  end
end
