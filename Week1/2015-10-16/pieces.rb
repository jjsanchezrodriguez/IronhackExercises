class Piece
  attr_accessor :position, :future
  def initialize
    @position = {x: 0, y: 0}
    @future = {x: 0, y: 0}
  end
end

class Rook < Piece
end

class Pawn < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class King < Piece
end

class BlackPawn < Pawn 
end

class BlackKnight < Knight
end

class BlackRook < Rook
end

class BlackBishop < Bishop
end

class BlackQueen < Queen
end

class BlackKing < King
end

class WhitePawn < Pawn 
end

class WhiteKnight < Knight
end

class WhiteRook < Rook
end

class WhiteBishop < Bishop
end

class WhiteQueen < Queen
end

class WhiteKing < King
end
