# coding: utf-8

class Director
  def initialize
    $pnum = 2
    $size = 9
    $map_size = $size * 2 - 1
    $turn = 1
    $mode = :pawn
    $map = Array.new( $map_size ){ Array.new( $map_size, 0 ) }
    @actionflag = false
    @key = Hash.new
    @font = Font.new(14)
    @p1_pawn = Pawn.new(1)
    @p2_pawn = Pawn.new(2)
    @p1_wall = Array.new( 20/$pnum, Wall.new )
    @p2_wall = Array.new( 20/$pnum, Wall.new )
    @p1_wnum = 0
    @p2_wnum = 0
  end
  
  def input
    @key[:p1_up]    = Input.key_push?( K_UP )
    @key[:p1_down]  = Input.key_push?( K_DOWN )
    @key[:p1_left]  = Input.key_push?( K_LEFT )
    @key[:p1_right] = Input.key_push?( K_RIGHT )
    @key[:p1_wall]  = Input.key_push?( K_RSHIFT )
    @key[:p1_spin]  = Input.key_push?( K_RETURN )
    
    @key[:p2_up]    = Input.key_push?( K_W )
    @key[:p2_down]  = Input.key_push?( K_S )
    @key[:p2_left]  = Input.key_push?( K_A )
    @key[:p2_right] = Input.key_push?( K_D )
    @key[:p2_wall]  = Input.key_push?( K_LSHIFT )
    @key[:p2_spin]  = Input.key_push?( K_Z )
    
    @key[:turn_end] = Input.key_push?( K_SPACE )
    @key[:full_scr] = Input.key_push?( K_TAB )
  end
  
  def draw
    Window.draw_font( 100, 100, "turn:1", @font ) if $turn == 1
    Window.draw_font( 100, 100, "turn:2", @font ) if $turn == 2
    Window.draw_font( 200, 200, "setable", @font ) if @p1_wall[0].setable?( @p1_pawn.x, @p1_pawn.y, @p1_pawn.num )
    Window.draw_font( 300, 300, "set", @font ) if @p2_wall[0].setflag
  end
  
  def play
    Window.windowed = !Window.windowed? if @key[:full_scr]
    
    case $turn
    when 1
      case $mode
      when :pawn
        @p1_pawn.move( :up ) if @key[:p1_up] and @p1_pawn.movable?( :up )
        @p1_pawn.move( :down ) if @key[:p1_down] and @p1_pawn.movable?( :down )
        @p1_pawn.move( :left ) if @key[:p1_left] and @p1_pawn.movable?( :left )
        @p1_pawn.move( :right ) if @key[:p1_right] and @p1_pawn.movable?( :right )
      when :wall
        @p1_wall[@p1_wnum].move( :up ) if @key[:p1_up] and @p1_wall.movable?( :up )
        @p1_wall[@p1_wnum].move( :down ) if @key[:p1_down] and @p1_wall.movable?( :down )
        @p1_wall[@p1_wnum].move( :left ) if @key[:p1_left] and @p1_wall.movable?( :left )
        @p1_wall[@p1_wnum].move( :right ) if @key[:p1_right] and @p1_wall.movable?( :right )
      end
    when 2
      case $mode
      when :pawn
        @p2_pawn.move( :up ) if @key[:p2_up] and @p2_pawn.movable?( :up )
        @p2_pawn.move( :down ) if @key[:p2_down] and @p2_pawn.movable?( :down )
        @p2_pawn.move( :left ) if @key[:p2_left] and @p2_pawn.movable?( :left )
        @p2_pawn.move( :right ) if @key[:p2_right] and @p2_pawn.movable?( :right )
      when :wall
        @p2_wall[@p2_wnum].move( :up ) if @key[:p2_up] and @p2_wall.movable?( :up )
        @p2_wall[@p2_wnum].move( :down ) if @key[:p2_down] and @p2_wall.movable?( :down )
        @p2_wall[@p2_wnum].move( :left ) if @key[:p2_left] and @p2_wall.movable?( :left )
        @p2_wall[@p2_wnum].move( :right ) if @key[:p2_right] and @p2_wall.movable?( :right )
      end
    end
    
    if @actionflag and @key[:turn_end]
      if $mode == :wall
        case $turn
        when 1
          @p1_wall[@p1_wnum].set
          @p1_wnum += 1
        when 2
          @p2_wall[@p2_wnum].set
          @p2_wnum += 1
        end
      end
      $turn += 1
      $turn = 1 if $turn > $pnum
      @actionflag = false
    end
  end
end