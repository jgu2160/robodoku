class Solver

  attr_reader :board

  def initialize
    @board = []
    @solution = []
  end

  def intake_board(boardfile)
    File.readlines(boardfile).each do |line|
      game_row = line.delete("\n").split("")
      game_row.each_with_index { |number_string, index| game_row[index] = number_string.to_i}
      @board << game_row
    end
  end

  def spot_make
    @board.each_with_index do |row, row_index|
      row.each_with_index {|entry, column_index| row[column_index] = Spot.new([row_index, column_index], self.square_finder([row_index, column_index])) if entry == 0}
    end
  end

  def column_make(column_number)
    column_array = []
    @board.each {|row| column_array << row[column_number]}
    column_array
  end

  def square_make(square_number)
    case square_number
    when 1..3
      top_arrays = @board[0..2]
      self.squarer(square_number, top_arrays)
    when 4..6
      mid_arrays = @board[3..5]
      self.squarer(square_number, mid_arrays)
    when 7..9
      bottom_arrays = @board[6..8]
      self.squarer(square_number, bottom_arrays)
    end
  end

  def squarer(square_number, array_set)
    squared_array = []
    case square_number
    when 1, 4, 7 then array_set.each {|a| squared_array << a[0..2]}
    when 2, 5, 8 then array_set.each {|a| squared_array << a[3..5]}
    when 3, 6, 9 then array_set.each {|a| squared_array << a[6..8]}
    end
    squared_array.flatten
  end
  
  def square_finder(coordinate)
    case coordinate[0]
    when 0..2
      case coordinate[1]
        when 0..2 then 1
        when 3..5 then 2
        when 6..8 then 3
      end
    when 3..5 
      case coordinate[1]
        when 0..2 then 4
        when 3..5 then 5
        when 6..8 then 6
      end
    when 6..8 
      case coordinate[1]
        when 0..2 then 7
        when 3..5 then 8
        when 6..8 then 9
      end
    end
  end
  
  def evaluator(spot, chunk)
    spot.candidates = spot.candidates.reject {|x| chunk.include?(x)}
  end

  def chunk_check(spot)
    self.evaluator(spot, @board[spot.coordinates[0]])
    self.evaluator(spot, column_make(spot.coordinates[1]))
    self.evaluator(spot, square_make(spot.square))
  end
end

class Spot
  attr_accessor :candidates
  attr_reader :coordinates, :square

  def initialize(coordinates,square)
    @coordinates = coordinates
    @square = square 
    @candidates = (1..9).to_a
  end
end
