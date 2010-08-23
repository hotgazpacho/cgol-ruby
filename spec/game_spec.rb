require 'game'
require 'grid2d'
require 'dead_cell'
require 'live_cell'

describe Game, "when given a seed that is a Still Life" do
  before :each do
    @game = Game.new
  end
  describe "Block" do
    it "#tick returns a new Block" do
      seed = Grid2D.new 4,4, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Beehive" do
    it "#tick returns a new Beehive" do
      seed = Grid2D.new 5, 6, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Loaf" do
    it "#tick returns a new Loaf" do
      seed = Grid2D.new 6, 6, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
  describe "Boat" do
    it "#tick returns a new Boat" do
      seed = Grid2D.new 5, 5, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,DeadCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new]
      ]
      next_generation = @game.tick seed
      next_generation.should eql seed
      next_generation.should_not equal seed
    end
  end
end

describe Game, "when given a seed that is an Oscillator" do
  before :each do
    @game = Game.new
  end
  describe "Blinker (period 2)" do
    before :each do
      @period1 = Grid2D.new 5, 5, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,LiveCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new]
      ]
      @period2 = Grid2D.new 5, 5, [
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,LiveCell.new,LiveCell.new,LiveCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new],
        [DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new,DeadCell.new] 
      ] 
    end
    it "#tick with a seed in period 1 called once returns a Blinker in period 2" do
      next_generation = @game.tick @period1
      next_generation.should eql @period2
    end
    it "#tick with a seed in period 1 called twice returns a Blinker in period 1" do
      gen1 = @game.tick @period1
      gen2 = @game.tick gen1
      gen2.should eql @period1
    end
  end
end   
