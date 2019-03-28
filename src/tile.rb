class Tile < Sprite
  def initialize (x, y, image)
    super(to_pos(x) + $bx, to_pos(y) + $by, image)
  end

  def to_pos (val)
    val * 32
  end
end
