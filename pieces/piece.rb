# require_relative 'sliding_piece.rb'
# require_relative 'stepping_piece.rb'
# require_relative 'pawn.rb'

class Piece
  attr_reader :board, :color
  attr_accessor :position

  def to_s
    " #{@symbol} "
  end

  def inspect
    "#{self.object_id}"
  end

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    board[position]= self
    @symbol = ((color == :black) ? self.class::BLACK_SYMBOL : self.class::WHITE_SYMBOL)
  end

  def validate(moves)
    moves.select { |move| is_valid?(move) }
  end

  def friendly?(other_piece)
    self.color == other_piece.color
  end

  def enemy?(other_piece)
    return false if other_piece.nil?
    self.color != other_piece.color && !other_piece.nil?
  end

  def is_valid?(destination)
    return false unless board.in_bounds?(destination)
    target = board[destination]
    (target.nil? || enemy?(target))
  end

  def move_into_check?(destination)
    hypothetical = board.dup
    hypothetical.move!(self.position, destination)
    hypothetical.in_check?(color)
  end

end
