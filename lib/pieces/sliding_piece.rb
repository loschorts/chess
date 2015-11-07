
require_relative 'piece.rb'
require 'byebug'

class SlidingPiece < Piece

    DIAGONAL = [[1, 1], [-1, 1],[-1, -1], [1, -1]]
    ORTHAGONAL = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  def moves
    moves = []
    self.class::MOVE_DIRS.each do |direction|
      mag = 0
      last_pos = @position
      loop do
        mag += 1
        next_pos = [mag * direction[0] + position[0], mag * direction[1] + position[1]]
        break if(!is_valid?(next_pos) || enemy?(board[last_pos]))
        last_pos = next_pos
        moves << next_pos
      end
    end
    moves
  end

end
