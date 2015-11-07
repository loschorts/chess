class Piece
  attr_reader :board, :color
  attr_accessor :position

  def to_s
    " #{@symbol} "
  end

  def inspect
    to_s
  end

  def initialize(board, position, color)
    @board = board
    @position = position #@position = board.find(self)
    @color = color
    board[position]= self
    @symbol = ((color == :black) ? self.class::BLACK_SYMBOL : self.class::WHITE_SYMBOL)
  end

  def friendly?(other_piece)
    self.color == other_piece.color
  end

  def enemy?(other_piece)
    return false if other_piece.nil?
    self.color != other_piece.color && !other_piece.nil?
  end
  def moves
    #to be overwritten in each subclass
  end

  def possible_moves
    moves.select { |move| is_possible?(move) }
  end

  def is_possible?(destination)
    #validates only position, NOT check status
    return false unless board.in_bounds?(destination)
    target = board[destination]
    (target.nil? || enemy?(target))
  end

  def valid_moves
    moves.select {|move| is_valid?(move)}
  end

  def is_valid?(destination)
    #validates only check_status, NOT position
      hypothetical = self.board.dup
      hypothetical.move!(self.position, destination)
      hypothetical.in_check?(color)
  end

  def allowed_moves
    #returns moves that are possible and valid
    #this is the true and final filter of moves
    valid_moves & possible_moves
  end

end
