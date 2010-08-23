require 'cell_generator'
class Game
  def initialize
    @generator = CellGenerator.new
  end
  def tick(grid)
    next_gen = Grid2D.new(grid.height, grid.width)
    grid.each_with_position do |element, position|
      grid.neighbors(position[:x], position[:y]).each {|n| element.neighbors << n}
      next_gen[position[:x],position[:y]] = @generator.next_generation(element)
    end
    next_gen
  end
end
