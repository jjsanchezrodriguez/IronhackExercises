class Game
  attr_reader :origin, :destination
  def initialize(board, instructions)
    @board = board
    @origin = instructions[0] 
    @destination = instructions[1] 
    @current_piece = nil
  end

  def coordinate_converter(coordinates)
    ascii_letters = (97..104).map { |i| i.chr }
    converted = coordinates.split("").map do |char|
      unless ascii_letters.include?(char)
        COORDINATES[char.to_i]
      else
        COORDINATES[char.to_sym]
      end
    end
    converted
  end

  def translator
    @origin = coordinate_converter(@origin)
    @destination = coordinate_converter(@destination)
  end

  def set_up_current_piece
    @current_piece = @board[@origin[1]][@origin[0]]
    @current_piece.future[:x] = @destination[1]
    @current_piece.future[:y] = @destination[0]
  end

  def validate
    translator
    set_up_current_piece
    # begin tests
    is_empty? &&
    not_out_of_bounds? &&
    can_move_lateral? &&
    can_move_diagonal? &&
    jump_no_more_than_two?
  end

  def not_out_of_bounds?
    x = @current_piece.future[:x]
    y = @current_piece.future[:y]
    !(@board[x] && @board[x][y]).nil?
  end

  def is_empty?
    @board[@current_piece.future[:x]][@current_piece.future[:y]] == :empty
  end

  def can_move_lateral?
    laterals = [Pawn, Rook]
    if laterals.include?(@current_piece.class.superclass)
      laterals.each do |type|
        if @current_piece.class.superclass == type &&
            @current_piece.position[:y] == @current_piece.future[:y] || 
            @current_piece.position[:x] == @current_piece.future[:x]
              return true
        end
      end
    else
      return true
    end
  end

  def can_move_diagonal?
    if @current_piece.class.superclass == Pawn
      if @current_piece.future[:y] - @current_piece.position[:y] == 0
        return true
      else
        return false
      end
    else
      return true
    end
  end

  def jump_no_more_than_two?
    # pawn can go 2 squares at most
    if @current_piece.class.superclass == Pawn
      #binding.pry
      if @current_piece.position[:y] - @current_piece.future[:y] > 2 ||
      @destination[0] - @current_piece.position[:y] > 2
        return false
      elsif @current_piece.position[:x] - @current_piece.future[:x] > 2 ||
      @destination[1] - @current_piece.position[:x] > 2 
        return false
      else
        return true
      end
    else
      return true
    end
  end
end
