require_relative 'piece.rb'

class SteppingPiece < Piece

  def moves
    theoretical_moves = self.class::DIRECTIONS.map {|direction| [direction[0] + position[0], direction[1] + position[1]]}
    validate(theoretical_moves)
  end

end
