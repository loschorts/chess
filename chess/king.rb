require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'stepping_piece.rb'

class King < SteppingPiece

  DIRECTIONS = [
    [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]
  ]
  
end
