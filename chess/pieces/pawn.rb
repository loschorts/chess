require_relative 'piece.rb'

class Pawn < Piece

  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265f"
  
  attr_accessor :moved
  attr_reader :step
  def initialize(board, position, color, moved = false)
    super(board, position, color)
    @moved = moved
    color == :white ? @step = -1 : @step = 1
  end

  def moves
    moves = []
    row, col = position

    one_step = [(row + step), col]
    two_step = [row + (step * 2), col]

    if moved == false
      moves << two_step if board[one_step].nil?
    end

    moves << one_step if board[one_step].nil?
    diag_left = [(row + step), col - 1]
    diag_right = [(row + step), col + 1]
    moves << diag_left if enemy?(board[diag_left])
    moves << diag_right if enemy?(board[diag_right])

    moves.select{|move| is_valid?(move)}

  end

  def move
    @moved == true
  end

end



if __FILE__ == $0
  b = Board.new
  enemypawn = Pawn.new(b, [5,4], :black)
  pawn = Pawn.new(b, [6,5], :white, true)
  p pawn.moves
end
