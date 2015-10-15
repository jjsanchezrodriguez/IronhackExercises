class Room
  attr_accessor :items
  def initialize(name, description, description_visited, items, exits)
    @name = name
    @description = description
    @description_visited = description_visited
    @items = items
    @exits = exits
  end
end
