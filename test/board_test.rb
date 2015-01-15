require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/board'
require './lib/solver'
require 'byebug'

class BoardTest < MiniTest::Test
  attr_reader :spot

  def test_it_takes_in_file_and_formats_into_usable_matrix
    test_board_1 = Board.new("./boards/easy_matrix.txt")
    assert_equal [[1, 2, 3],[4, 5, 6],[7, 8, 9]], test_board_1.board
  end
end
#
#   def setup
#     @spot = Spot.new
#     # @solver.board_intake("board_2.txt")
#     # @solver.spot_make
#   end
#
#   def test_spot_initialized_with_9_unique_candidates
#     assert_equal 9, spot.candidates.uniq.length
#   end
#
#
# end
