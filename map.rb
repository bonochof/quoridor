# coding: utf-8

class Map
  attr_reader :pawn, :wall
  
  def initialize
    @pawn = Array.new( $size ){ Array.new( $size, 0 ) }
    @wall = Array.new( $size-1 ){ Array.new( $size-1, 0 ) }
  end
end
