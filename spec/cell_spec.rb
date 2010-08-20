require 'live_cell'
require 'dead_cell'

describe LiveCell do
  it "should be alive" do
    c = LiveCell.new
    c.alive?.should be_true
  end
end

describe DeadCell do
  it "should not be alive" do
    c = DeadCell.new
    c.alive?.should be_false
  end
end
