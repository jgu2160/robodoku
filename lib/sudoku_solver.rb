require 'byebug'
class Solver
  attr_reader :board
  #divide between easy/hard solver method for speed?

  def initialize(boardfile)
    @board = ChunkMaker.new.board_intake(boardfile)
    @solution = []
  end

#board intake via chunk_maker
#solver via solver
#better solver via medium_algo
#best solver via swordfish

end
