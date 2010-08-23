require 'cell'

class DeadCell
  include Cell
  def alive?
    false
  end
  def inspect
    "0"
  end
  def ==(other)
    other.kind_of? DeadCell
  end
  def eql?(other)
    self == other
  end
end

