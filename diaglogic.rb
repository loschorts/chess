def diag_row_empty? start_pos, end_pos
  raise 'empty line' if start_pos == end_pos

  start_row, start_column = start_pos
  end_row, end_column = end_pos

  raise 'not diagonal' unless start_row - end_row == start_column - end_column

  length = (start_row-end_row).abs

  row_step = start_row < end_row ? 1 : -1
  col_step = start_column < end_column ? 1 : -1

  row_idx = start_row
  col_idx = start_column

  squares_between = []

  (length-1).times do
    row_idx += row_step
    col_idx += col_step
    squares_between << [row_idx, col_idx]
  end
  squares_between.all? {|square| board[square].nil?}
  #squares_between #comment this line in and above line out to test
end

p diag_row_empty? [0,0], [0,8]
