# coding: utf-8

class Map
  attr_reader :map
  
  def initialize( pnum )
    size = 9
    @map = Array.new( size ){ Array.new( size, 0 ) }
  end
end
