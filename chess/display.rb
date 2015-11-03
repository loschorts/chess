require 'colorize'
require_relative 'board.rb'
require_relative 'cursorable.rb'

class Display
  attr_accessor :cursor
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor = [5,5]
    @selected = false
  end

  def render
    board.grid.each_with_index do |row, i|
      row.each_index do |j|
        current_character = board[[i, j]]
        current_character = "_" if current_character.nil?
        current_character = current_character.colorize(:red) if cursor == [i, j]
        print "[#{current_character}]"
      end
      puts
    end
  end
  def inspect
    puts
  end
end

puts "abc".colorize(:red)

board = Board.new
display = Display.new(board)

display.render
