require_relative 'sliding_piece'

class Rook < SlidingPiece
  MOVE_DIRS = ORTHAGONAL

  WHITE_SYMBOL = "\u2656"
  BLACK_SYMBOL = "\u265c"
end
