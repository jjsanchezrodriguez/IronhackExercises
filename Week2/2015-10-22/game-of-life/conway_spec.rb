require 'rspec'
require './cell'
require './conway'

describe Cell do
  it "#regenerates - less than two alive neighbours, cell dies" do
    cell1 = Cell.new(1, [0, 0, 0, 0, 0, 0, 0, 1])
    cell1.regenerate
    expect(cell1.state).to eq(0)

    cell2 = Cell.new(1, [0, 0, 0, 0, 0, 1, 1, 1])
    cell2.regenerate
    expect(cell2.state).to eq(1)
  end

  it "#regenerates - live cell with 2 or 3 live neighbours lives on" do
    cell1 = Cell.new(1, [0, 0, 0, 0, 0, 1, 1, 1])
    cell1.regenerate
    expect(cell1.state).to eq(1)

    cell2 = Cell.new(1, [0, 0, 0, 0, 0, 0, 1, 1])
    cell2.regenerate
    expect(cell2.state).to eq(1)
  end

  it "#regenerates - live cell with more than 3 live neighbours dies" do
    cell1 = Cell.new(1, [0, 0, 0, 0, 1, 1, 1, 1])
    cell1.regenerate
    expect(cell1.state).to eq(0)
  end

  it "#regenerates - dead cell w/ exactly 3 live neighbours arises from dead" do
    cell1 = Cell.new(0, [0, 0, 0, 0, 0, 1, 1, 1])
    cell1.regenerate
    expect(cell1.state).to eq(1)
  end
end


describe Game do

  before :each do
    @game = Game.new
  end

  it "has 100-square grid" do
    squares = @game.grid.reduce(0) { |sum, line| sum + line.size } 
    expect(squares).to eq(100)
  end
  
  it "#add_cell - can't go out of bounds" do
    expect(@game.add_cell(11, 9)).to be_falsy
    expect(@game.add_cell(1, 99)).to be_falsy
    expect(@game.add_cell(1, 9)).to be_truthy
  end

  it "#add_cell - adds cells on grid" do
    @game.add_cell(0, 0)
    @game.add_cell(1, 1)
    @game.add_cell(2, 2)
    count = @game.grid.flatten.select { |grid| grid.class == Cell }.size
    expect(count).to eq(3)
  end

  it "#add_cell - can't add cells on same position" do
    @game.add_cell(0, 0)
    expect(@game.add_cell(0, 0)).to be_falsy
  end

  it "#fill - fills 0 with dead cells" do
    @game.add_cell(0, 0)
    @game.add_cell(0, 1)
    @game.add_cell(2, 1)
    @game.fill
    count = @game.grid.flatten.select { |cell| cell.state == 0 }.size
    expect(count).to eq(97)
  end

  it "#get_neighbours - calculate neighbours, should be two live cells" do
    @game.add_cell(0, 0)
    @game.add_cell(0, 1)
    @game.add_cell(1, 1)
    @game.fill
    @game.get_neighbours
    live = @game.grid[0][0].neighbours.select { |cell| cell.state == 1 }
    expect(live).to eq(2)
  end

end
