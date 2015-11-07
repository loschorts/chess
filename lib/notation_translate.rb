moves = [%w[f2 f3], %w[e7 e5], %w[g2 g4], %w[d8 h4]]

def translate move
  positions = move
  positions.map do |pos|
    col = ('a'..'h').to_a.find_index(pos.split("")[0])
    row = 8 - pos.split("")[1].to_i
    [row, col]
  end
  #positions
end

moves.map {|move| p translate move}
