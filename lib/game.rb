class Game
  def tick(grid)
    data = Array.new(grid.height) { Array.new(grid.width) }
    grid.each_with_position { |element, position| data[position[:y]][position[:x]] = element }
    Grid2D.new data
  end
end
