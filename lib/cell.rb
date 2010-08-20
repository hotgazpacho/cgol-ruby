module Cell
  attr_reader :neighbors
  def initialize
    @neighbors = []
  end
  def fertile?
    live_neighbor_count == 3
  end
  def sustainable?
    [2,3].include? live_neighbor_count
  end
  def live_neighbor_count
    @neighbors.select {|c| c.alive?}.size
  end  
end

