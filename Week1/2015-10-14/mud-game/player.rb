class Player
  attr_accessor :inventory, :position, :visited
  attr_reader :name
  def initialize(name, inventory = {}, position = "hallway" , visited = [])
    @name = name
    @inventory = inventory
    @position = position
    @visited = visited
  end
end
