class Cell
  attr_reader :state, :neighbours
  def initialize(state, neighbours)
    @state = state
    @neighbours = neighbours
  end

  def regenerate
    alive = @neighbours.select { |n| n == 1 }

    if @state == 1
      alive.size < 2 || alive.size > 3 ? @state = 0 : @state = 1
    end

    if @state == 0
      alive.size == 3 ? @state = 1 : @state = 0
    end
  end
end
