require './lib/spot'

class Board
  attr_reader :game_grid
  def initialize(board_file)
    @game_grid = []
    self.board_intake(board_file)
  end

  def board_intake(boardfile)
    File.readlines(boardfile).each do |line|
      game_row = line.delete("\n").split("")
      self.row_make(game_row)
    end
    self.spot_make
  end

  def chunk_make(spot)
    [@game_grid[spot.row_index], column_make(spot.column_index), square_make(spot.row_index, spot.column_index)]
  end

  def row_make(game_row)
    game_row.each_with_index { |number_string, index| game_row[index] = number_string.to_i}
    @game_grid << game_row
  end

  def spot_make
    @game_grid.each_with_index do |row, row_index|
      row.each_with_index {|entry, column_index| row[column_index] = Spot.new(row_index, column_index) if entry == 0}
    end
  end

  def column_make(column_number)
    @game_grid.transpose[column_number]
  end

  def square_make(row_number, column_number)
    row = (row_number/3)*3
    col = (column_number/3)*3
    @game_grid[row, 3].flat_map { |r| r[col, 3] } # nobel peace prize
  end
end
