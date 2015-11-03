require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'stepping_piece.rb'

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
