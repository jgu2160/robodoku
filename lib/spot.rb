class Spot
  attr_accessor :candidates
  attr_reader :row_index, :column_index, :square

  def initialize(row_index=nil, column_index=nil, square=nil)
    @row_index = row_index
    @column_index = column_index
    @square = square
    @candidates = (1..9).to_a
  end

  def candidate_delete(chunk)
    @candidates.reject! {|candidate| chunk.include?(candidate)}
  end

end
