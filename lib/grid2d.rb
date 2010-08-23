class Grid2D
  attr_reader :height, :width

  def initialize(height, width, data = [])
    @height = height
    @width = width
    if data.empty?
      @data = Array.new(height) { Array.new(width) }
    else
      @data = data
    end
  end

  def ==(other)
    @data.eql? other.data
  end

  def eql?(other)
    self == other
  end

  def each(&blk)
    @data.flatten.each(&blk)
  end

  def each_with_position(&blk)
    @data.each_index do |y|
      @data[y].each_index do |x|
        yield self[x,y], { :x => x, :y => y}
      end
    end
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

  def []=(x,y,value)
    @data[y][x] = value
  end

  def inspect
    inspect_string = ''
    y = -1
    self.each_with_position do |element, position|
      inspect_string << "\n" if position[:y] > y
      inspect_string << element.inspect
      y = position[:y]
    end
    inspect_string << "\n"
  end

  protected
  def data
    @data
  end

end

