require './lib/board'

class Solver
  GOLDEN_NUMBER = 405

  def initialize(board)
    @board = board
    self.board_solve
  end

  def board_solve
    until self.board_clean?
      @board.game_grid.each do |row|
        row.each { |element| self.board_reduce(element) if element.is_a?(Spot) }
      end
    end
    puts @board
  end

  def board_clean?
    @board.game_grid.flatten.any? {|entry| entry.is_a?(Spot)} ? false : self.board_solved?
  end


  def board_reduce(spot_element)
    self.chunk_check(spot_element)
    self.spot_replace(spot_element) if self.candidate_alone?(spot_element)
    # self.candidate_transform_by_unique_candidate(spot_element)
    #swordfish
  end

  def board_solved?
    @board.game_grid.flatten.reduce(:+) == GOLDEN_NUMBER #? puts("Solution correct. You just got robodoku'd.") : puts("Loser.")
  end

  def chunk_check(spot)
    # byebug
    @board.chunk_make(spot).each {|chunk| spot.candidate_delete(chunk)}
  end

  def spot_replace(spot)
    @board.game_grid[spot.row_index][spot.column_index] = spot.candidates[0]
  end

  def candidate_alone?(spot)
    spot.candidates.length == 1
  end

end
