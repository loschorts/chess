class Piece
  attr_reader :board, :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def valid_moves
    moves.select { |move| is_valid?(move) }
  end

  def friendly?(other_piece)
    self.color == other_piece.color
  end

  def valid?(destination)
    target = board[destination]
    board.in_bounds?(destination) && !target.friendly?
  end

end
