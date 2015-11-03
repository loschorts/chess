require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'stepping_piece.rb'

class King < SteppingPiece

  DIRECTIONS = [
    [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]
  ]

  def moves
    DIRECTIONS.map {|direction| [direction[0] + position[0], direction[1] + position[1]]}
  end

end
