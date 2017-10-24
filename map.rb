# coding: utf-8

class Map
  attr_reader :man, :wall
  
  def initialize
    @man = Array.new( $size ){ Array.new( $size, 0 ) }
    @wall = Array.new( $size-1 ){ Array.new( $size-1, 0 ) }
  end
end
