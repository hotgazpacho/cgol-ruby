require 'grid2d'

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

  describe "#each" do
    before :each do
      @g = Grid2D.new [
        [ 0, 1, 2, 3],
        [ 4, 5, 6, 7],
        [ 8, 9,10,11],
        [12,13,14,15],
        [16,17,18,19]
      ]
    end
    it "yields each element in the grid, row by row" do
      list = []
      @g.each { |e| list << e}
      list.should =~ (0..19).to_a
    end
  end

  describe "#each_with_position" do
    before :each do
      @g = Grid2D.new [
        [ 0, 1, 2, 3],
        [ 4, 5, 6, 7],
        [ 8, 9,10,11],
        [12,13,14,15],
        [16,17,18,19]
      ]
    end

    it "yields each element in the grid with its position" do
      list = []
      @g.each_with_position { |element, position| list << [element, position]}
      expected = []
      (0..4).each do |y|
        (0..3).each do |x|
          expected << [ @g[x,y], { :x => x, :y => y} ]
        end
      end
      list.should =~ expected
    end
  end

  describe "equality" do
    before :each do
        @grid1 = Grid2D.new [
          [0,1,2],
          [3,4,5],
          [6,7,8]
        ]
        @grid2 = Grid2D.new [
          [0,1,2],
          [3,4,5],
          [6,7,8]
        ]
    end
    describe "#==" do
      it "should return true when each element is equal to the corresponding element in the other" do
        (@grid1 == @grid2).should be_true
      end
    end
    describe "eql?" do
      it "should return true when each element is equal to the corresponding element in the other" do
        @grid1.eql?(@grid2).should be_true
      end
    end
  end
end

