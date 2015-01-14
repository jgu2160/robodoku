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

class Spot
  attr_accessor :candidates
  attr_reader :row_index, :column_index, :square

  def initialize(row_index, column_index, square)
    @row_index = row_index
    @column_index = column_index
    @square = square
    @candidates = (1..9).to_a
  end
end
