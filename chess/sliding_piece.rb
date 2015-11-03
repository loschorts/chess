require_relative 'piece.rb'

class SlidingPiece < Piece

    DIAGONAL = [[1, 1], [-1, 1],[-1, -1], [1, -1]]
    ORTHAGONAL = [[1, 0], [0, -1], [-1, 0], [0, 1]]

  def moves
    moves = []
    current = nil
    self.class::MOVE_DIRS.each do |direction|
      mag = 0
      last_pos = position
      loop do
        mag += 1
        next_pos = [mag * direction[0] + position[0], mag * direction[1] + position[1]]
        break if(!next_pos.is_valid? && enemy?(board[last_pos]))
        last_pos = next_pos
        moves << next_pos
      end
    end
    moves
  end

  def is_valid?

  end

end

class Rook < SlidingPiece
  MOVE_DIRS = ORTHAGONAL
  # def move_dirs
  #   ORTHAGONAL
  # end
end

class Queen < SlidingPiece
  MOVE_DIRS = ORTHAGONAL + DIAGONAL
end
