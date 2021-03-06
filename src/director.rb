class Director
  def initialize
    $bx = 140
    $by = 160
    $size = 9
    $mapsize = $size * 2 - 1
    @turn = TURN::PLAYER1
    $scene = SCENE::NEUTRAL
    $map = Array.new($mapsize) { Array.new($mapsize, 0) }
    $delta = 0
    @input = Hash.new
    @font = Font.new(32)
    @endflag = false
    @wall = nil

    # Game objects
    @tiles = []
    $size.times do |y|
      @tiles << Array.new($size).map.with_index{|tile, x| Tile.new(x, y, Image[:tile])}
    end
    @walls = [Array.new(10), Array.new(10)]
    @walls.map!.with_index do |wall, i|
      wall.map!.with_index do |obj, j|
        Wall.new(i + 1, i * 400 + $bx - 90, j * 32 + $by, Image[:wall])
      end
    end
    @pawns = [Pawn.new(1, 0, 4, Image[:pawn1]), Pawn.new(2, 8, 4, Image[:pawn2])]
    @mouse = Sprite.new(0, 0, Image.new(1, 1))
  end

  def input
    @mouse.x, @mouse.y = Input.mouse_pos_x, Input.mouse_pos_y
    @input[:click] = Input.mouse_push?(M_LBUTTON)
    @input[:spin] = Input.key_push?(K_S)
  end

  def draw
    # Game board
    Sprite.draw(@tiles)
    Sprite.draw(@pawns)
    Sprite.draw(@walls)

    Window.draw_font(10, 10, "turn:#{@turn}", @font)
    Window.draw_font(300, 10, "scene:#{$scene}", @font)
  end

  def play
    if @input[:click]
      if $scene != SCENE::NEUTRAL
        @turn += 1
        @turn %= 2
        $scene = SCENE::NEUTRAL
      elsif @mouse === @pawns[@turn]
        $scene = SCENE::MOVE_PAWN
      elsif @mouse === @walls[@turn]
        @wall = @mouse.check(@walls[@turn])
        $scene = SCENE::MOVE_WALL
      end
    end

    if $scene == SCENE::MOVE_WALL
      @wall.map{|wall| wall.move(@mouse)}
      @wall.map{|wall| wall.spin} if @input[:spin]
    end
    #Window.windowed = !Window.windowed? if @key[:full_scr]
=begin
    if !@endflag
      if $delta == 0 and (($turn == 1 and @key[:p1_mode]) or ($turn == 2 and @key[:p2_mode]))
        case $mode
        when :pawn
          $mode = :wall if ($turn == 1 and @p1_wnum < 20 / $pnum) or ($turn == 2 and @p2_wnum < 20 / $pnum)
        when :wall
          $mode = :pawn
        end
      end

      case $turn
      when 1
        case $mode
        when :pawn
          @p1_pawn.move(:up) if @key[:p1_up] and @p1_pawn.movable?(:up)
          @p1_pawn.move(:down) if @key[:p1_down] and @p1_pawn.movable?(:down)
          @p1_pawn.move(:left) if @key[:p1_left] and @p1_pawn.movable?(:left)
          @p1_pawn.move(:right) if @key[:p1_right] and @p1_pawn.movable?(:right)
        when :wall
          @p1_wall[@p1_wnum].move(:up) if @key[:p1_up] and @p1_wall[@p1_wnum].movable?(:up)
          @p1_wall[@p1_wnum].move(:down) if @key[:p1_down] and @p1_wall[@p1_wnum].movable?(:down)
          @p1_wall[@p1_wnum].move(:left) if @key[:p1_left] and @p1_wall[@p1_wnum].movable?(:left)
          @p1_wall[@p1_wnum].move(:right) if @key[:p1_right] and @p1_wall[@p1_wnum].movable?(:right)
          @p1_wall[@p1_wnum].spin if @key[:p1_spin]
        end
      when 2
        case $mode
        when :pawn
          @p2_pawn.move(:up) if @key[:p2_up] and @p2_pawn.movable?(:up)
          @p2_pawn.move(:down) if @key[:p2_down] and @p2_pawn.movable?(:down)
          @p2_pawn.move(:left) if @key[:p2_left] and @p2_pawn.movable?(:left)
          @p2_pawn.move(:right) if @key[:p2_right] and @p2_pawn.movable?(:right)
        when :wall
          @p2_wall[@p2_wnum].move(:up) if @key[:p2_up] and @p2_wall[@p2_wnum].movable?(:up)
          @p2_wall[@p2_wnum].move(:down) if @key[:p2_down] and @p2_wall[@p2_wnum].movable?(:down)
          @p2_wall[@p2_wnum].move(:left) if @key[:p2_left] and @p2_wall[@p2_wnum].movable?(:left)
          @p2_wall[@p2_wnum].move(:right) if @key[:p2_right] and @p2_wall[@p2_wnum].movable?(:right)
          @p2_wall[@p2_wnum].spin if @key[:p2_spin]
        end
      end

      if $delta > 0 and @key[:turn_end]
        @endflag = true if @p1_pawn.goal? or @p2_pawn.goal?

        case $mode
        when :pawn
          case $turn
          when 1
            @p1_pawn.update
          when 2
            @p2_pawn.update
          end
        when :wall
          case $turn
          when 1
            @p1_wall[@p1_wnum].update
            @p1_wnum += 1
          when 2
            @p2_wall[@p2_wnum].update
            @p2_wnum += 1
          end
          $mode = :pawn
        end
        $turn += 1
        $turn = 1 if $turn > $pnum
        $delta = 0
      end
    end
=end
  end
end
