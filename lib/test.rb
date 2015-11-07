require_relative 'game'

game = Game.new(Board.simple_checkmate)

p "white pieces: #{game.board.get_pieces_of(:white)}"
p "white moves", game.board.get_moves_of(:white)
p "white checkmate #{game.board.checkmate? (:white)}"
p "black checkmate #{game.board.checkmate? (:black)}"
