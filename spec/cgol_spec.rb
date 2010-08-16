require 'spec'

module Cell
  attr_reader :neighbors
  def initialize
    @neighbors = []
  end
  private
  def live_neighbor_count
    @neighbors.select {|c| c.is_a? LiveCell}.size
  end
  def fertile?
    live_neighbor_count == 3
  end
  def sustainable?
    [2,3].include? live_neighbor_count
  end
end

class LiveCell
  include Cell
  def next_generation
    sustainable? ? LiveCell.new : DeadCell.new
  end
end

class DeadCell
  include Cell
  def next_generation
    fertile? ? LiveCell.new : DeadCell.new
  end
end

describe LiveCell do
  describe "next_generation" do
    before :each do
      @live_cell = LiveCell.new
    end
    it "produces a DeadCell when it has fewer than 2 LiveCell neighbors" do
      @live_cell.neighbors << LiveCell.new
      next_gen_cell = @live_cell.next_generation
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a DeadCell when it has more than 3 LiveCell neighbors" do
      (1..4).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @live_cell.next_generation
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a LiveCell when it has 2 LiveCell neighbors" do
      (1..2).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @live_cell.next_generation
      next_gen_cell.should be_kind_of LiveCell
    end
    it "produces a LiveCell when it has 3 LiveCell neighbors" do
      (1..3).each { @live_cell.neighbors << LiveCell.new }
      next_gen_cell = @live_cell.next_generation
      next_gen_cell.should be_kind_of LiveCell
    end
  end
end

describe DeadCell do
  describe "next_generation" do
    before :each do
      @dead_cell = DeadCell.new
    end
    it "produces a LiveCell when it has 3 LiveCell neighbors" do
      (1..3).each { @dead_cell.neighbors << LiveCell.new }
      next_gen_cell = @dead_cell.next_generation
      next_gen_cell.should be_kind_of LiveCell
    end
    it "produces a DeadCell when it has less than 3 LiveCell neighbors" do
      next_gen_cell = @dead_cell.next_generation
      next_gen_cell.should be_kind_of DeadCell
    end
    it "produces a DeadCell when it has more than 3 LiveCell neighbors" do
      (1..4).each { @dead_cell.neighbors << LiveCell.new }
      next_gen_cell = @dead_cell.next_generation
      next_gen_cell.should be_kind_of DeadCell
    end
  end
end
