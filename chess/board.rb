class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate!
  end

  def populate!

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def move(start_pos, end_pos)
    unless on_board?(start_pos) && on_board?(end_pos)
      raise RuntimeError.new("Come on, bro...")
    end
    raise RuntimeError.new("You didn't select a piece!") if self[start_pos].nil?
    #unless self[start_pos].valid_moves.include?(end_pos)
    #  raise RuntimeError.new("Invalid move for that piece!")
    #end

    self[start_pos], self[end_pos] = nil, self[start_pos]
  end

  def in_bounds?(pos)
    pos.all? {|x| (0...8).include?(x)}
  end

  def line_type(start_pos, end_pos)
    start_row, start_column = start_pos
    end_row, end_column = end_pos

    if start_row == end_row
      pieces_between = @grid[start_row][start_column+1...end_column]
    end

    return :vertical if start_column == end_column
    return :diagonal if

    pieces_between.all? {|piece| piece.nil? || !piece.friendly?}
  end



  def to_s
    result = ""
    @grid.each do |row|
      row.each do |el|
        if el.nil?
          result << "_"
        else
          result << el.to_s
        end
      end
      result << "\n"
    end
    result
  end

end
