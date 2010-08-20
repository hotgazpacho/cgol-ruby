require 'cell'
require 'live_cell'
require 'dead_cell'

class CellGenerator
  def next_generation(cell)
    if cell.sustainable? or cell.fertile?
      LiveCell.new
    else
      DeadCell.new
    end
  end
end

