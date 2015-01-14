class Solver

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


end
