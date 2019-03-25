class Director
  def initialize
    $pnum = 2
    $size = 9
    $mapsize = $size * 2 - 1
    $turn = 1
    $mode = :pawn
    $map = Array.new($mapsize) { Array.new($mapsize, 0) }
    $delta = 0
    @key = Hash.new
    @font = Font.new(32)
    @p1_pawn = Pawn.new(1)
    @p2_pawn = Pawn.new(2)
    @p1_wall = Array.new(20/$pnum).map{ Wall.new }
    @p2_wall = Array.new(20/$pnum).map{ Wall.new }
    @p1_wnum = 0
    @p2_wnum = 0
    @endflag = false
    @mouse = Sprite.new(0, 0, Image.new(0, 0))
  end

  def input
    @key[:p1_up]    = Input.key_push?(K_UP)
    @key[:p1_down]  = Input.key_push?(K_DOWN)
    @key[:p1_left]  = Input.key_push?(K_LEFT)
    @key[:p1_right] = Input.key_push?(K_RIGHT)
    @key[:p1_mode]  = Input.key_push?(K_RSHIFT)
    @key[:p1_spin]  = Input.key_push?(K_RETURN)

    @key[:p2_up]    = Input.key_push?(K_W)
    @key[:p2_down]  = Input.key_push?(K_S)
    @key[:p2_left]  = Input.key_push?(K_A)
    @key[:p2_right] = Input.key_push?(K_D)
    @key[:p2_mode]  = Input.key_push?(K_LSHIFT)
    @key[:p2_spin]  = Input.key_push?(K_Z)

    @key[:turn_end] = Input.key_push?(K_SPACE)
    @key[:full_scr] = Input.key_push?(K_TAB)
  end

  def draw
    Window.draw_font(10, 10, "turn:1", @font) if $turn == 1
    Window.draw_font(10, 10, "turn:2", @font) if $turn == 2
    Window.draw_font(10, 30, "wall", @font) if $mode == :wall
    Window.draw_font(100, 10, "setable", @font) if @p1_wnum > 0 and @p2_wnum > 0 and (($turn == 1 and @p1_wall[@p1_wnum].setable?(@p1_pawn.x, @p1_pawn.y, 1)) or ($turn == 2 and @p2_wall[@p2_wnum].setable?(@p2_pawn.x, @p2_pawn.y, 2)))
    Window.draw_font(740, 540, (20/$pnum-@p1_wnum).to_s, @font)
    Window.draw_font(20, 540, (20/$pnum-@p2_wnum).to_s, @font)

    $map.each_with_index do |line, i|
      line.each_with_index do |val, j|
        case val
        when 0
          Window.draw(j * 32 / 2, i * 32 / 2, Image[:tile]) if i % 2 == 0 and j % 2 == 0
        when 1
          #Window.draw_line(j * 32 / 2, i * 32 / 2)
          #Window.draw_font(j*33+100, i*33+30, "×", @font)
        when 2
          Window.draw(j * 32 / 2, i * 32 / 2, Image[:tile])
          Window.draw(j * 32 / 2, i * 32 / 2, Image[:pawn1])
        when 3
          Window.draw(j * 32 / 2, i * 32 / 2, Image[:tile])
          Window.draw(j * 32 / 2, i * 32 / 2, Image[:pawn2])
        end
      end
    end
    @mouse.draw
  end

  def play
    #Window.windowed = !Window.windowed? if @key[:full_scr]

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
  end
end
