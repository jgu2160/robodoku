require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './solver.rb'

class SolverTest < MiniTest::Test

  def setup
    @solver = Solver.new

  end

  def test_it_exists
    assert @solver
  end

  def test_it_has_a_board_instance_variable
    assert @solver.board
  end

  def test_it_provides_candidates
    assert_equal [4,5,6,7,8,9],@solver.evaluator([1,2,3])
  end

  def test_it_makes_a_column_of_3
    skip
    column_1 = @solver.column_maker(0)
    assert_equal [1,4,7], column_1
  end

  def test_it_makes_an_int_board
    assert @solver.intake_board("board_1.txt")
  end

  def test_it_makes_a_column_of_9
    @solver.intake_board("board_1.txt")
    column_2 = @solver.column_maker(0)
    assert_equal [8,7,3,1,9,2,5,4,6], column_2
  end

  def test_square_maker_makes_square_1
    @solver.intake_board("board_1.txt")
    square1 = @solver.square_maker(1)
    assert_equal [8,2,6,7,1,5,3,9,4], square1
  end

  def test_square_maker_makes_middle_square
    @solver.intake_board("board_1.txt")
    square5 = @solver.square_maker(5)
    assert_equal [4,5,9,2,6,7,8,1,3], square5
  end




end
