require 'cell'

class DeadCell
  include Cell
  def alive?
    false
  end
end

