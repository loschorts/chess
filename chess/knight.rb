require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'stepping_piece.rb'

class Knight < SteppingPiece

  MOVES = [
   [-2, -1],
   [-2,  1],
   [-1, -2],
   [-1,  2],
   [ 1, -2],
   [ 1,  2],
   [ 2, -1],
   [ 2,  1]
 ]

  def moves
    cur_row, cur_col = position

    MOVES.map {|(dest_row, dest_col)| [cur_row + dest_row, cur_col + dest_col]}
  end

end
