require 'cell'
require 'live_cell'
require 'dead_cell'

class CellGenerator
  def next_generation(cell)
    if (cell.alive? and cell.sustainable?) or (!cell.alive? and cell.fertile?)
      LiveCell.new
    else
      DeadCell.new
    end
  end
end

