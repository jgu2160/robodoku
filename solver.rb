require 'byebug'
class Solver
  attr_reader :board

  def initialize
    @board = []
    @solution = []
  end

  def board_intake(boardfile)
    @board = []
    File.readlines(boardfile).each do |line|
      game_row = line.delete("\n").split("")
      self.row_make(game_row)
      self.row_make(game_row)
    end
    self.spot_make
  end

  def row_make(game_row)
    game_row.each_with_index { |number_string, index| game_row[index] = number_string.to_i}
    @board << game_row
    #testing a change
  end


  def spot_make
    @board.each_with_index do |row, row_index|
      row.each_with_index {|entry, column_index| row[column_index] = Spot.new(row_index, column_index, self.square_finder(row_index, column_index)) if entry == 0}
    end
  end

  def column_make(column_number)
    column_array = []
    @board.each {|row| column_array << row[column_number]}
    column_array
  end

  def square_make(square_number)
    case square_number
    when 1..3
      top_arrays = @board[0..2]
      self.squarer(square_number, top_arrays)
    when 4..6
      mid_arrays = @board[3..5]
      self.squarer(square_number, mid_arrays)
    when 7..9
      bottom_arrays = @board[6..8]
      self.squarer(square_number, bottom_arrays)
    end
  end

  def squarer(square_number, array_set)
    squared_array = []
    case square_number
    when 1, 4, 7 then array_set.each {|a| squared_array << a[0..2]}
    when 2, 5, 8 then array_set.each {|a| squared_array << a[3..5]}
    when 3, 6, 9 then array_set.each {|a| squared_array << a[6..8]}
    end
    squared_array.flatten
  end

  def square_finder(row_index, column_index)
    case row_index
    when 0..2
      case column_index
        when 0..2 then 1
        when 3..5 then 2
        when 6..8 then 3
      end
    when 3..5
      case column_index
        when 0..2 then 4
        when 3..5 then 5
        when 6..8 then 6
      end
    when 6..8
      case column_index
        when 0..2 then 7
        when 3..5 then 8
        when 6..8 then 9
      end
    end
  end

  def easy_candidate_delete(spot, chunk)
    spot.candidates = spot.candidates.reject {|x| chunk.include?(x)}
  end

  def easy_chunk_check(spot)
    self.chunk_make(spot).each {|chunk| self.easy_candidate_delete(spot, chunk)}
  end

  def chunk_make(spot)
    [@board[spot.row_index], column_make(spot.column_index), square_make(spot.square)]
  end

  def candidate_pool(spot, chunk)
    other_candidate_pool = []
    chunk.each do |entry|
      if entry.is_a?(Spot) && entry.object_id != spot.object_id
        other_candidate_pool << entry.candidates
      end
    end
    self.candidate_pool_condense(other_candidate_pool)
    #where to do check/select method?
  end

  def candidate_select?(spot, pool)
    1 == spot.candidates.select {|candidate| !pool.include?(candidate)}.length
  end

  def candidate_pool_condense(pool)
    pool.flatten.uniq
  end

  def candidate_alone?(spot)
    spot.candidates.length == 1
  end

  def spot_remove(spot)
    @board[spot.row_index][spot.column_index] = spot.candidates[0]
  end

  def spot_scan
    while self.board_clean?
      @board.each do |row|
        row.each { |entry| self.sudoku_solve(entry) if entry.is_a?(Spot) }
      end
    end
  end

  def board_solved?
    @board.flatten.reduce(:+) == 405 ? puts("Solution correct. You just got robodoku'd.") : puts("Loser.")
  end

  def board_clean?
    @board.flatten.any? {|entry| entry.is_a?(Spot)} ? true : self.board_solved?
  end

  def sudoku_solve(entry)
    self.easy_chunk_check(entry)
    self.spot_remove(entry) if candidate_alone?(entry)
  end
end

class Spot
  attr_accessor :candidates
  attr_reader :row_index, :column_index, :square

  def initialize(row_index, column_index, square)
    @row_index = row_index
    @column_index = column_index
    @square = square
    @candidates = (1..9).to_a
  end
end
