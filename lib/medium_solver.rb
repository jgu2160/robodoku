require './lib/solver'

class MediumSolver < Solver

  def board_reduce(spot_element)
    super
    self.candidate_transform_by_unique_candidate(spot_element)
    #swordfish
  end

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
    @board.chunk_make(spot).each do |chunk|
      pool = candidate_pool(spot, chunk)
      if candidate_single?(spot, pool)
        spot.candidate_delete(pool)
        self.spot_replace(spot)
      end
    end
  end

  def candidate_single?(spot, pool)
    1 == spot.candidates.select {|candidate| !pool.include?(candidate)}.length
  end

  def candidate_pool_condense(pool)
    pool.flatten.uniq
  end

end
