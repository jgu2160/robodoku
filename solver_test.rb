require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './solver.rb'
require 'byebug'

class SolverTest < MiniTest::Test

  def setup
    @solver = Solver.new
    @solver.intake_board("board_2.txt")
    @solver.spot_make
  end

  def test_it_exists
    assert @solver
  end

  def test_it_has_a_board_instance_variable
    puts @solver.board[0]
  end
  
  def test_it_finds_a_coordinate
    a = @solver.board[0][1]
    assert_equal [0,1], @solver.location_finder(a)
  end

  
  def test_it_finds_the_right_square
    square_3 = [0, 6]
    square_5 = [3, 3]
    square_8 = [8, 3]
    assert_equal 3, @solver.square_finder(square_3)
    assert_equal 5, @solver.square_finder(square_5)
    assert_equal 8, @solver.square_finder(square_8)
  end
end

class SpotTest < MiniTest::Test
  def test_evaluator_evaluates_arrays
    spot = Spot.new(nil,nil)
    assert_equal [4,5,6,7,8,9], spot.evaluator([1,2,3])
    assert_equal [4,5,6,7,8,9], spot.candidates
  end
end
