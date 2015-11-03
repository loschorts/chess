require_relative 'sliding_piece'

class Bishop < SlidingPiece
  MOVE_DIRS = DIAGONAL
  WHITE_SYMBOL = "\u2657"
  BLACK_SYMBOL = "\u265d"
end
