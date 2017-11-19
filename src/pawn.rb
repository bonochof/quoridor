# coding: utf-8

class Pawn
  attr_reader :x, :y
  
  def initialize( pnum )
    case pnum
    when 1
      pos_x = 16
      pos_y = 8
    when 2
      pos_x = 0
      pos_y = 8
    when 3
      pos_x = 8
      pos_y = 16
    when 4
      pos_x = 8
      pos_y = 0
    else
      abort "player number is wrong"
    end
    
    @num = pnum
    @x = pos_x
    @y = pos_y
    @x_old = @x
    @y_old = @y
    
    $map[@y][@x] = 2 if @num == 1
    $map[@y][@x] = 3 if @num == 2
  end
  
  def movable?( dir )
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
  
  def move( dir )
    $map[@y][@x] = 0 if $turn == 1
    $map[@y][@x] = 0 if $turn == 2
    
    case dir
    when :up
      @y -= 2
      @y -= 2 if self.movable?( :up ) and $map[@y][@x] != 0
    when :down
      @y += 2
      @y += 2 if self.movable?( :down ) and $map[@y][@x] != 0
    when :left
      @x -= 2
      @x -= 2 if self.movable?( :left ) and $map[@y][@x] != 0
    when :right
      @x += 2
      @x += 2 if self.movable?( :right ) and $map[@y][@x] != 0
    end

    $map[@y][@x] = 2 if $turn == 1
    $map[@y][@x] = 3 if $turn == 2
    
    $delta = ( @x - @x_old ).abs + ( @y - @y_old ).abs
  end
  
  def update
    @x_old = @x
    @y_old = @y
  end
  
  def goal?
    case @num
    when 1
      return true if @x == 0
    when 2
      return true if @x == $mapsize - 1
    end
    return false
  end
end
