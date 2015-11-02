require 'colorize'

class Display
  attr_accessor :cursor
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor = [0,0]
    @selected = false
  end

  def to_s
    display_string = board.to_s
    cursor_index = (cursor[0] * 9) + cursor[1]
    cursor = display_string[cursor_index].colorize(:pink)
    colorized_string =
      display_string[0...cursor_index] + cursor + display_string[cursor_index+1..-1]
  end
  def render
    to_s.split("").each do |char|
      print " " + char
    end
  end
  def inspect
    puts
  end
end
