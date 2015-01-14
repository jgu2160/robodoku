require 'byebug'
class Solver
  attr_reader :board
  #divide between easy/hard solver method for speed?

  def initialize(boardfile)
    @board = ChunkMaker.new.board_intake(boardfile)
    @solution = []
  end

  def spot_scan
    while self.board_clean?
      @board.each do |row|
        row.each { |entry| self.sudoku_solve(entry) if entry.is_a?(Spot) }
      end
    end
  end

  private

  def easy_candidate_delete(spot, chunk)
    spot.candidates = spot.candidates.reject {|x| chunk.include?(x)}
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
    self.candidate_transform_by_unique_candidate(entry)
  end

  def easy_chunk_check(spot)
    self.chunk_make(spot).each {|chunk| self.easy_candidate_delete(spot, chunk)}
  end

  def spot_remove(spot)
    @board[spot.row_index][spot.column_index] = spot.candidates[0]
  end


  MEDIUM - HARD ALGORITHM

  def candidate_pool(spot, chunk)
    other_candidate_pool = []
    chunk.each do |entry|
      if entry.is_a?(Spot) && entry.object_id != spot.object_id
        other_candidate_pool << entry.candidates
      end
    end
    self.candidate_pool_condense(other_candidate_pool)
  end






  def candidate_transform_by_unique_candidate(spot)
    self.chunk_make(spot).each do |chunk|
      pool = candidate_pool(spot, chunk)
      if candidate_single?(spot, pool)
        self.easy_candidate_delete(spot, pool)
        self.spot_remove(spot)
      end
    end
  end

  def candidate_single?(spot, pool)
    1 == spot.candidates.select {|candidate| !pool.include?(candidate)}.length
  end

  def candidate_pool_condense(pool)
    pool.flatten.uniq
  end

  def candidate_alone?(spot)
    spot.candidates.length == 1
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
