require 'cell'

class LiveCell
  include Cell
  def alive?
    true
  end
  def inspect
    "1"
  end
  def ==(other)
    other.kind_of? LiveCell
  end
  def eql?(other)
    self == other
  end
end

