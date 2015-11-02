require_relative "card"

class Board
  attr_reader :size, :rows

  def initialize(size = 4)
    @rows = Array.new(size) { Array.new(size) }
    @size = size
    populate
  end

  def [](pos)
    x, y = pos
    rows[x][y]
  end

  def []=(pos, value)
    begin
    x, y = pos
    unless (0...size).include?(x) && (0...size).include?(y)
      raise ArgumentError.new("Position off of Board!")
    end
    rescue ArgumentError => e
      puts e.message
      print "enter new position: "
      pos = gets.chomp.split(",").map(&:to_i)
      retry

    end
    rows[x][y] = value
  end

  def hide(pos)
    self[pos].hide
  end

  def reveal(pos)
    if revealed?(pos)
      puts "You can't flip a card that has already been revealed."
    else
      self[pos].reveal
    end
    self[pos].value
  end

  def populate
    num_pairs = (size ** 2) / 2
    cards = Card.shuffled_pairs(num_pairs)
    rows.each_index do |i|
      rows[i].each_index do |j|
        self[[i, j]] = cards.pop
      end
    end
  end

  def render
    system("clear")
    puts "  #{(0...size).to_a.join(" ")}"
    rows.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end

  def revealed?(pos)
    self[pos].revealed?
  end

  def won?
    rows.all? do |row|
      row.all? { |card| card.revealed? }
    end
  end

  private
  attr_reader :rows
end
