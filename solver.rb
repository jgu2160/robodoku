require 'pry'

class Solver

  attr_reader :board

  def initialize
    @board = []
  end

  def intake_board(boardfile)
    File.readlines(boardfile).each do |line|
      var = line.delete("\n").split("")
      var.each_with_index { |v, index| var[index] = v.to_i}
      @board << var
    end
  end



  def evaluator(array)
    nine_array = (1..9).to_a
    candidates = nine_array.reject {|x| array.include?(x)}
  end

  def column_maker(column_number)
    column_array = []
    @board.each {|row| column_array << row[column_number]}
    column_array
  end

  def square_maker(square_number)
    case square_number
    when 1..3
      top_arrays = @board[0..2]
      self.squarer(square_number, top_arrays)
    when 4..6
      mid_arrays = @board[3..5]
      self.squarer(square_number, mid_arrays)
    when 7..9
      bottom_arrays = @test_boards[6..8]
      self.squarer(square_number, bottom_arrays)
    end
  end

  def squarer(square_number, array_set)
    squared_array = []
    case square_number
    when 1..3 then array_set.each {|a| squared_array << a[0..2]}
    when 4..6 then array_set.each {|a| squared_array << a[3..5]}
    when 7..9 then array_set.each {|a| squared_array << a[6..8]}
    end
    squared_array.flatten
  end
end

class Spot
  def initialize
    @candidates = (1..9).to_a
  end


end
