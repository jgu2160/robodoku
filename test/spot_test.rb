require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/spot'
require './lib/solver'
require 'byebug'

class SpotTest < MiniTest::Test
  attr_reader :spot

  def setup
    @spot = Spot.new
    # @solver.board_intake("board_2.txt")
    # @solver.spot_make
  end

  def test_spot_initialized_with_9_unique_candidates
    assert_equal 9, spot.candidates.uniq.length
  end

  def test_spot_has_correct_coordinates
    spot_2 = Spot.new(0, 8)
    assert_equal 0, spot_2.row_index
    assert_equal 8, spot_2.column_index
  end

  def test_it_deletes_candidates_when_compared_to_chunk
    spot.candidate_delete([1,2,3,4,5,6,7])
    assert_equal [8,9], spot.candidates
  end

  # def test_spot_is_never_nil
  #
  # end

end
