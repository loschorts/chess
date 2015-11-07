require_relative 'sliding_piece'

class Queen < SlidingPiece
  MOVE_DIRS = ORTHAGONAL + DIAGONAL

  WHITE_SYMBOL = "\u2655"
  BLACK_SYMBOL = "\u265b"
end
