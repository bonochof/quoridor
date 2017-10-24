# coding: utf-8

class Director
  def initialize
    $pnum = 2
    $size = 9
    $turn = 1
    $mode = :pawn
    @key = Hash.new
    @font = Font.new(14)
    @map = Map.new
    @pawn1 = Pawn.new(1)
    @pawn2 = Pawn.new(2)
    @wall1 = Array( 20/$pnum, Wall.new )
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
  end
  
  def play
    @key.each do |key|
      case $turn
      when 1
        @pawn1.move(key) if key == true and $mode == :pawn
      when 2
        @pawn2.move(key) if key == true and $mode == :pawn
      end
    end
    
    $turn += 1 if @key[:turn_end] == true
    $turn = 1 if $turn > 2
  end
end
