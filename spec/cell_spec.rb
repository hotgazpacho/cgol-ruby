require 'live_cell'
require 'dead_cell'

describe LiveCell do
  it "should be alive" do
    c = LiveCell.new
    c.alive?.should be_true
  end
  describe "equality" do
    before :each do
      @c1 = LiveCell.new
      @c2 = LiveCell.new
    end
    it "#== should be true when compared to another LiveCell" do
      @c1.==(@c2).should be_true
    end
    it "#eql? should be true when compared to another LiveCell" do
      @c1.eql?(@c2).should be_true
    end
  end
end

describe DeadCell do
  it "should not be alive" do
    c = DeadCell.new
    c.alive?.should be_false
  end
  describe "equality" do
    before :each do
      @c1 = DeadCell.new
      @c2 = DeadCell.new
    end
    it "#== should be true when compared to another DeadCell" do
      @c1.==(@c2).should be_true
    end
    it "#eql? should be true when compared to another DeadCell" do
      @c1.eql?(@c2).should be_true
    end
  end
end
