require 'game'
require 'grid2d'

describe Game, "when given a seed that is a Still Life" do
  before :each do
    @game = Game.new
  end
  describe "Block" do
    it "#tick returns a new Block" do
      seed = Grid2D.new [
        [0,0,0,0],
        [0,1,1,0],
        [0,1,1,0],
        [0,0,0,0]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Beehive" do
    it "#tick returns a new Beehive" do
      seed = Grid2D.new [
        [0,0,0,0,0,0],
        [0,0,1,1,0,0],
        [0,1,0,0,1,0],
        [0,0,1,1,0,0],
        [0,0,0,0,0,0]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Loaf" do
    it "#tick returns a new Loaf" do
      seed = Grid2D.new [
        [0,0,0,0,0,0],
        [0,0,1,1,0,0],
        [0,1,0,0,1,0],
        [0,0,1,0,1,0],
        [0,0,0,1,0,0],
        [0,0,0,0,0,0]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Boat" do
    it "#tick returns a new Boat" do
      seed = Grid2D.new [
        [0,0,0,0,0],
        [0,1,1,0,0],
        [0,1,0,1,0],
        [0,0,1,0,0],
        [0,0,0,0,0]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
end
