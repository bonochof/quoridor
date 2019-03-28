class Pawn < Sprite
  def initialize (id, x, y, image)
    @player_id = id
    super(to_pos(x) + $bx, to_pos(y) + $by, image)
  end

  def to_pos (val)
    val * 32
  end

=begin
  def movable? (dir)
    case dir
    when :up
      return false if $delta > 0 and @y - 2 != @y_old
      if @y - 1 > 0
        return false if $map[@y-1][@x] == 1
        return false if $map[@y-2][@x] != 0 and @y - 3 < 0
        return true
      end
    when :down
      return false if $delta > 0 and @y + 2 != @y_old
      if @y + 1 < $mapsize
        return false if $map[@y+1][@x] == 1
        return false if $map[@y+2][@x] != 0 and @y + 3 > $mapsize
        return true
      end
    when :left
      return false if $delta > 0 and @x - 2 != @x_old
      if @x - 1 > 0
        return false if $map[@y][@x-1] == 1
        return false if $map[@y][@x-2] != 0 and @x - 3 < 0
        return true
      end
    when :right
      return false if $delta > 0 and @x + 2 != @x_old
      if @x + 1 < $mapsize
        return false if $map[@y][@x+1] == 1
        return false if $map[@y][@x+2] != 0 and @x + 3 > $mapsize
        return true
      end
    end

    return false
  end

  def move (dir)
    $map[@y][@x] = 0 if $turn == 1
    $map[@y][@x] = 0 if $turn == 2

    case dir
    when :up
      @y -= 2
      @y -= 2 if self.movable?(:up) and $map[@y][@x] != 0
    when :down
      @y += 2
      @y += 2 if self.movable?(:down) and $map[@y][@x] != 0
    when :left
      @x -= 2
      @x -= 2 if self.movable?(:left) and $map[@y][@x] != 0
    when :right
      @x += 2
      @x += 2 if self.movable?(:right) and $map[@y][@x] != 0
    end

    $map[@y][@x] = 2 if $turn == 1
    $map[@y][@x] = 3 if $turn == 2

    $delta = (@x - @x_old).abs + (@y - @y_old).abs
  end

  def goal?
    case @player_id
    when 1
      return true if @x == 0
    when 2
      return true if @x == $mapsize - 1
    end
    return false
  end
=end
end
