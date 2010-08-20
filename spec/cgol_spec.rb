require 'spec'

class CellGenerator
  def next_generation(cell)
    if cell.sustainable? or cell.fertile?
      LiveCell.new
    else
      DeadCell.new
    end
  end
end

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

class LiveCell
  include Cell
  def initialize
    super
    @state = :alive
  end
  def alive?
    true
  end
end

class DeadCell
  include Cell
  def alive?
    false
  end
end

class Grid2D
  def initialize(data)
    @data = data
  end

  def neighbors(x,y)
    adj = []
    (x-1 .. x+1).each do |x_pos|
      (y-1 .. y+1).each do |y_pos|
        adj << self[x_pos,y_pos] unless (x == x_pos and y == y_pos)
      end
    end
    adj
  end

  def [](x,y)
    if x < 0 then x = self.width - x.abs end
    if x >= self.width then x = x - self.width end
    if y >= self.height then y = y - self.height end
    @data[y][x]
  end

  def width
    @data.first.size
  end

  def height
    @data.size
  end

end

describe Grid2D do
  describe "#[](x,y)" do
    before :each do
      @g = Grid2D.new [
        [ 0, 1, 2, 3],
        [ 4, 5, 6, 7],
        [ 8, 9,10,11],
        [12,13,14,15],
        [16,17,18,19]
      ]
    end
    it "fetches the value when both x and y are within the range of width and height" do
      @g[2,1].should equal 6
    end
    it "fetches the value when x is negative and y is within the range of column height" do
      @g[-1,0].should equal 3
    end
    it "fetches the value when x is greater the range of row width and y is within the range of column height" do
      @g[4,0].should equal 0
    end
    it "fetches the value when x is within the row width and y is negative" do
      @g[1,-1].should equal 17
    end
    it "fetches the value when x is within the row width and y is greater than the row height" do
      @g[2,5].should equal 2
    end
  end
  describe "#neighbors(x,y) provides a list of adjacent elements for an element" do
    before :each do
      @g = Grid2D.new [
        [ 0, 1, 2, 3],
        [ 4, 5, 6, 7],
        [ 8, 9,10,11],
        [12,13,14,15],
        [16,17,18,19]
      ]
    end
    it "not on an edge" do
      neighbors = @g.neighbors(1,1)
      neighbors.should =~ [0,1,2,4,6,8,9,10]
    end
    it "in the upper left corner" do
      neighbors = @g.neighbors(0,0)
      neighbors.should =~ [1,3,4,5,7,16,17,19]
    end
    it "in the upper right corner" do
      neighbors = @g.neighbors(3,0)
      neighbors.should =~ [0,2,4,6,7,16,18,19]
    end
    it "in the lower right corner" do
      neighbors = @g.neighbors(3,4)
      neighbors.should =~ [14,15,18,12,16,2,3,0]
    end
    it "in the lower left corner" do
      neighbors = @g.neighbors(0,4)
      neighbors.should =~ [12,13,15,17,19,0,1,3]
    end
    it "on the left edge" do
      neighbors = @g.neighbors(0,2)
      neighbors.should =~ [4,5,7,9,11,12,13,15]
    end
    it "on the right edge" do
      neighbors = @g.neighbors(3,2)
      neighbors.should =~ [4,6,7,8,10,12,14,15]
    end
    it "on the bottom edge" do
      neighbors = @g.neighbors(1,4)
      neighbors.should =~ [12,13,14,16,18,0,1,2]
    end
    it "on the top edge" do
      neighbors = @g.neighbors(2,0)
      neighbors.should =~ [1,3,5,6,7,17,18,19]
    end
  end
end

describe CellGenerator do
  before :each do
    @generator = CellGenerator.new
  end
  describe "Current cell is a LiveCell" do
    before :each do
      @live_cell = LiveCell.new
    end
    it "produces a DeadCell when it has fewer than 2 LiveCell neighbors" do
      @live_cell.neighbors << LiveCell.new
      next_gen_cell = @generator.next_generation @live_cell
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a DeadCell when it has more than 3 LiveCell neighbors" do
      (1..4).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @generator.next_generation @live_cell
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a LiveCell when it has 2 LiveCell neighbors" do
      (1..2).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @generator.next_generation @live_cell
      next_gen_cell.should be_kind_of LiveCell
    end
    it "produces a LiveCell when it has 3 LiveCell neighbors" do
      (1..3).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @generator.next_generation @live_cell
      next_gen_cell.should be_kind_of LiveCell
    end
  end
  describe "Current cell is a DeadCell" do
    before :each do
      @dead_cell = DeadCell.new
    end
    it "produces a LiveCell when it has 3 LiveCell neighbors" do
      (1..3).each { @dead_cell.neighbors << LiveCell.new }
      next_gen_cell = @generator.next_generation @dead_cell
      next_gen_cell.should be_kind_of LiveCell
    end
    it "produces a DeadCell when it has less than 3 LiveCell neighbors" do
      next_gen_cell = @generator.next_generation @dead_cell
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a DeadCell when it has more than 3 LiveCell neighbors" do
      (1..4).each { @dead_cell.neighbors << LiveCell.new }
      next_gen_cell = @generator.next_generation @dead_cell
      next_gen_cell.should be_kind_of DeadCell
    end
  end
end
