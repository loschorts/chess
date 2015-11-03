require_relative 'stepping_piece'
#
class King < SteppingPiece

  DIRECTIONS = [
    [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]
  ]
  WHITE_SYMBOL = "\u2654"
  BLACK_SYMBOL = "\u265a"

end
