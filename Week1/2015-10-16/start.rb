require 'pry'
require './pieces'
require './chessboard'
require './game'

# THIS VERSION TAKES INTO ACCOUNT ALL PIECES
# CHESSBOARD IS SET UP WITH ALL THE PIECES
# AND INSTRUCTIONS ARE COMPARED WITH THAT IN MIND
# NO MOVES ARE PERFORMED, ONLY A CHECK
# EACH INSTRUCTION FROM `MOVES.TXT` SETS UP NEW
# CHESSBOARD
#
# implementing function for knight not sure if last
# move (b8 -> a6) is legal or not

chessboard = [
  ['bR', 'bN', 'bB', 'bQ', 'bK', 'bB', 'bN', 'bR'],
  ['bP', 'bP','bP','bP','bP','bP','bP','bP','bP'],
  [nil, nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil, nil],
  [nil, nil, nil, nil, nil, nil, nil, nil, nil],
  ['wP', 'wP','wP','wP','wP','wP','wP','wP','wP'],
  ['wR', 'wN', 'wB', 'wQ', 'wK', 'wB', 'wN', 'wR'],
]

TYPES = {
  'bP' => BlackPawn, 'bN' => BlackKnight, 'bB' => BlackBishop,
  'bQ' => BlackQueen, 'bK' => BlackKing, 'bR' => BlackRook,
  'wP' => WhitePawn, 'wB' => WhiteBishop, 'wN' => WhiteKnight,
  'wQ' => WhiteQueen, 'wK' => WhiteKing, 'wR' => WhiteRook
}

COORDINATES = {
  :a => 0, :b => 1, :c => 2, :d => 3, :e => 4, :f => 5, :g => 6, :h => 7,
  1 => 7, 2 => 6, 3 => 5, 4 => 4, 5 => 3, 6 => 2, 7 => 1, 8 => 0
}

instructions = IO.readlines("moves.txt").map do |line|
  line.chomp
  line.split
end


board = ChessBoard.new(chessboard).parse

instructions.each do |game|
  move = Game.new(board, game)
  str = "From #{game[0]} to #{game[1]} is "
  if move.validate
    str += "LEGAL"
  else
    str += "ILLEGAL"
  end

  puts str
end

