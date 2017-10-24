# coding: utf-8

class Director
  def initialize
    $turn = 1
    $mode = :man
    @key = Hash.new
    @font = Font.new(14)
    @map = Map.new
    @player1 = Man.new(1)
    @player2 = Man.new(2)
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
        @player1.movable?(key) if key == true and $mode == :man
      when 2
        @player2.movable?(key) if key == true and $mode == :man
      end
    end
    
    $turn += 1 if @key[:turn_end] == true
    $turn = 1 if $turn > 2
  end
end
