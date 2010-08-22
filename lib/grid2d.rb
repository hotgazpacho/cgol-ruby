class Grid2D
  def initialize(data)
    @data = data
  end

  def each(&blk)
    @data.flatten.each(&blk)
    #@data.each do |row|
    #  row.each &blk
    #end
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

