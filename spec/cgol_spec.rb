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

require'matrix'
class Grid2D < Matrix
  def neighbors(i,j)
    neighbors = [] 
    xs(i).each do |x|
      ys(j).each do |y|
        neighbors << self.[](x,y) unless x == i and y == j
      end
    end
    neighbors
  end

  protected
  def xs(i)
    [i-1, i, i+1].delete_if {|n| n < 0 or n >= self.row_size}
  end
  def ys(j)
    [j-1, j, j+1].delete_if {|n| n < 0 or n >= self.column_size}
  end
end

describe Grid2D do
  describe "#neighbors provides a list of adjacent elements for an element" do
    before :each do
      @g = Grid2D[
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
      neighbors.should =~ [1,4,5]
    end
    it "in the upper right corner" do
      neighbors = @g.neighbors(0,3)
      neighbors.should =~ [2,6,7]
    end
    it "in the lower right corner" do
      neighbors = @g.neighbors(4,3)
      neighbors.should =~ [14,15,18]
    end
    it "in the lower left corner" do
      neighbors = @g.neighbors(4,0)
      neighbors.should =~ [12,13,17]
    end
    it "on the top edge" do
      neighbors = @g.neighbors(0,2)
      neighbors.should =~ [1,3,5,6,7]
    end
    it "on the right edge" do
      neighbors = @g.neighbors(2,3)
      neighbors.should =~ [6,7,10,14,15]
    end
    it "on the bottom edge" do
      neighbors = @g.neighbors(4,1)
      neighbors.should =~ [12,13,14,16,18]
    end
    it "on the left edge" do
      neighbors = @g.neighbors(2,0)
      neighbors.should =~ [4,5,9,12,13]
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
