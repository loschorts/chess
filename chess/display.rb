require 'colorize'
require_relative 'board.rb'
require_relative 'cursorable.rb'

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
    board.grid.each_with_index do |row, i|
      row.each_index do |j|
        current_character = board[[i, j]]
        current_character = "_" if current_character.nil?
        current_character = current_character.colorize(:red) if cursor_pos == [i, j]
        print "[#{current_character}]"
      end
      puts
    end
  end
  def inspect
    puts
  end

  def get_player_input
    move = nil
    until move
      render
      move = get_input
    end
    cursor_pos
  end

  def get_move
    start_pos = get_player_input
    selected = true
    end_pos = get_player_input
    selected = false
    [start_pos, end_pos]
  end

end

puts "abc".colorize(:red)

board = Board.new
display = Display.new(board)

 p display.get_move
