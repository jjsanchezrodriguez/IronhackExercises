class ChessBoard
  def initialize(layout)
    @layout = layout
    @board = []
  end

  def parse
    @board = @layout.map do |line|
      line.map do |square|
        remap_layout(square)
      end
    end
    get_coordinates
  end

  def remap_layout(square)
    unless square == nil
      TYPES[square].new
    else
      :empty
    end
  end

  def get_coordinates
    @board.map do |line|
      line.map do |piece|
        unless piece == :empty
          piece.position[:x] = @board.index(line)
          piece.position[:y] = line.index(piece)
        end
      end
    end
    return @board
  end
end

