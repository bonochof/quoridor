# coding: utf-8

class Director
  def initialize
    @key = Hash.new
    @font = Font.new(14)
    @map = Map.new
    player1 = Man.new(1)
    player2 = Man.new(2)
  end
  
  def input
    @key[:p1_up]    = Input.key_push?( K_UP )
    @key[:p1_down]  = Input.key_push?( K_DOWN )
    @key[:p1_left]  = Input.key_push?( K_LEFT )
    @key[:p1_right] = Input.key_push?( K_RIGHT )
    @key[:p1_wall]  = Input.key_push?( K_RETURN )
    
    @key[:p2_up]    = Input.key_push?( K_NUMPAD8 )
    @key[:p2_down]  = Input.key_push?( K_NUMPAD2 )
    @key[:p2_left]  = Input.key_push?( K_NUMPAD4 )
    @key[:p2_right] = Input.key_push?( K_NUMPAD6 )
    @key[:p2_wall]  = Input.key_push?( K_NUMPADENTER )
  end
  
  def play
    Window.draw_font(100,100,"return",@font) if @key[:p1_wall]
  end
end
