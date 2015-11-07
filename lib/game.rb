require_relative 'board.rb'

class Game
  attr_reader :board
  def initialize (board = Board.new)
    @board = board
  end

  def play
    winner = nil
    while winner.nil?
      begin
      board.display.render
      board.move(*board.get_move)
      winner = :white if board.checkmate?(:black)
      winner = :black if board.checkmate?(:white)
      rescue MoveError => e
        puts e.message
        gets
        retry
      end
    end
    puts "checkmate, winner: #{winner}"

  end
end

if __FILE__ == $0
  Game.new.play
end
