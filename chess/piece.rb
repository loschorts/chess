class Piece
  attr_reader :board, :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    board[position]= self
  end

  def valid_moves
    moves.select { |move| is_valid?(move) }
  end

  def friendly?(other_piece)
    self.color == other_piece.color
  end

  def is_valid?(destination)
    target = board[destination]
    board.in_bounds?(destination) && (target.nil? || !friendly?(target))
  end

end
