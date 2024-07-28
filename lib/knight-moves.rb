module KnightMoves
  def move_up_right
    adjust(1, 2)
  end
  def move_up_left
    adjust(-1, 2)
  end
  def move_right_up
    adjust(2, 1)
  end
  def move_right_down
    adjust(2, -1)
  end
  def move_down_right
    adjust(1, -2)
  end
  def move_down_left
    adjust(-1, -2)
  end
  def move_left_down
    adjust(-2, -1)
  end
  def move_left_up
    adjust(-2, 1)
  end

  private

  def adjust(dx, dy)
    @position[0] += dx
    @position[1] += dy
  end
end
