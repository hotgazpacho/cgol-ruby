class Game
  def tick(grid)
    next_gen = Grid2D.new(grid.height, grid.width)
    grid.each_with_position { |element, position| next_gen[position[:x],position[:y]] = element }
    next_gen
  end
end
