# coding: utf-8

class Director
  def initialize
    $pnum = 2
    $size = 9
    $turn = 1
    $mode = :pawn
    @actionflag = false
    @key = Hash.new
    @font = Font.new(14)
    @map = Map.new
    @p1_pawn = Pawn.new(1)
    @p2_pawn = Pawn.new(2)
    @p1_wall = Array.new( 20/$pnum, Wall.new )
    @p2_wall = Array.new( 20/$pnum, Wall.new )
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
    Window.draw_font( 200, 200, "setable", @font ) if @p1_wall[0].setable?
    Window.draw_font( 300, 300, "set", @font ) if @p2_wall[0].setflag
  end
  
  def play
=begin
    @key.each do |key|
      case $turn
      when 1
        @pawn1.move(key) if key == true and $mode == :pawn
      when 2
        @pawn2.move(key) if key == true and $mode == :pawn
      end
    end
=end
    Window.windowed = !Window.windowed? if @key[:full_scr]
    
    @p1_pawn.move( :up ) if @key[:p1_up] and @p1_pawn.movable?( :up )
    @p1_pawn.move( :down ) if @key[:p1_down] and @p1_pawn.movable?( :down )
    @p1_pawn.move( :left ) if @key[:p1_left] and @p1_pawn.movable?( :left )
    @p1_pawn.move( :right ) if @key[:p1_right] and @p1_pawn.movable?( :right )
=begin    
    @p1_wall[0].x -= 1 if @key[:p1_left] and @p1_wall.setable?
    @p1_wall[0].x += 1 if @key[:p1_right] and @p1_pawn.x < $size-1
    @p1_wall[0].y -= 1 if @key[:p1_up] and @p1_pawn.y > 0
    @p1_wall[0].y += 1 if @key[:p1_down] and @p1_pawn.y < $size-1
    @p1_wall[0].set if @key[:p1_wall]
    @p2_wall[0].set if @key[:p2_wall]
=end    
    if @actionflag and @key[:turn_end]
      $turn += 1
      $turn = 1 if $turn > $pnum
      @actionflag = false
    end
  end
end
