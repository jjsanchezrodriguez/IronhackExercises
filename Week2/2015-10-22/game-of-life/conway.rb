require './cell'
require 'pry'

class Game
  attr_accessor :grid
  attr_reader :outcome
  def initialize
    @grid = structure
    @outcome = nil
  end

  def add_cell(x, y)
    if @grid[x] && @grid[x][y] == 0
      insert(x, y)
    else
      false
    end
  end

  def insert(x, y)
    @grid[x][y] = Cell.new(1, nil) 
  end

  def get_neighbours
    @grid.each_with_index do |y, y_index|
      y.each_with_index do |item, item_index|
        end
      end
    end
  end

  def fill
    @grid.each_with_index do |y, y_index|
      y.each_with_index do |item, item_index|
        if item == 0
          @grid[y_index][item_index] = Cell.new(0, nil)
        end
      end
    end
  end


  def play
  end
end


def structure
  [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  ]
end
