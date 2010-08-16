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
