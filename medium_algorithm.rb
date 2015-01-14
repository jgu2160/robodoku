class MediumAlgorithm

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
