require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'stepping_piece.rb'

class SteppingPiece < Piece

  def moves
    theoretical_moves = DIRECTIONS.map {|direction| [direction[0] + position[0], direction[1] + position[1]]}
    validate(theoretical_moves)
  end

end

class Knight < SteppingPiece

  DIRECTIONS = [
   [-2, -1],
   [-2,  1],
   [-1, -2],
   [-1,  2],
   [ 1, -2],
   [ 1,  2],
   [ 2, -1],
   [ 2,  1]
 ]

end

class King < SteppingPiece

  DIRECTIONS = [
    [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]
  ]

end
