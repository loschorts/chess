class Piece
  attr_reader :board, :position

  def initialize(board, position)
    @board = board
    @position = position
  end

  def valid_moves
    moves.select { |move| is_valid?(move) }
  end

end
