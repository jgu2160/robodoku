require 'byebug'
class Robodoku
  attr_reader :board
  #divide between easy/hard solver method for speed?

  def initialize(boardfile)
    @board = Board.new(boardfile)
    @solver = Solver.new
    @solution = []
  end

  def complete_the_board
    @solver.board_solve(@board)
  end

# when :win puts "You just got robodoku'd" + board_output
#board intake via board
#solver via solver
#better medium_algo < solver
#best swordfish < solver

end
