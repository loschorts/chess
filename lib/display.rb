require 'colorize'
require_relative 'board.rb'
require_relative 'cursorable.rb'
require_relative 'gui'

class Display
  include Cursorable

  attr_accessor :cursor_pos, :selected
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [5,5]
    @selected = false
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    nil
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :black }
  end
  def inspect
    puts
  end

  def get_player_input
    move = nil
    until move
      render
      move = get_input
      p move
    end
    @cursor_pos = move
  end

  def get_move
    begin
      start_pos = get_player_input
      end_pos = get_player_input
      self.board.move(start_pos, end_pos)
    rescue MoveError => e
      puts e.message
      puts "(enter to continue)"
      gets
      retry
    end
    render
  end

end


class NilClass

  def to_s
    "   "
  end

end


if __FILE__ == $0
  board = Board.new
  display = Display.new(board)
  display.get_move
end
