require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'byebug'
require './lib/board'
require './lib/solver'
require './lib/spot'

class BoardTest < MiniTest::Test
  attr_reader :spot

  def test_it_takes_in_file_and_formats_into_usable_matrix
    test_board = Board.new("./boards/easy_matrix.txt")
    assert_equal [[1, 2, 3],[4, 5, 6],[7, 8, 9]], test_board.game_grid
  end

  def test_it_makes_a_spot_from_single_blank_space
    test_board = Board.new("./boards/single_space.txt")
    assert test_board.game_grid[0][0].is_a?(Spot)
  end

  def test_column_make_outputs_the_exactly_anticipated_column
    test_board = Board.new("./boards/board_3.txt")
    assert_equal [6,5,3,8,1,4,2,7,9], test_board.column_make(0)
  end

  def test_square_make_outputs_expected_square
    test_board = Board.new("./boards/board_3.txt")
    assert_equal [1,5,4,8,9,2,7,3,6], test_board.square_make(7,4)
  end
end
