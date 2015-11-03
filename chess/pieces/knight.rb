require_relative 'stepping_piece'

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

  WHITE_SYMBOL = "\u2658"
  BLACK_SYMBOL = "\u265e"
end
