# encoding: utf-8

## minitest setup

require 'minitest/autorun'


class EchoIO
  def initialize( buf )
    @io = StringIO.new( buf )
  end
  
  def gets
    str = @io.gets
    puts "|>#{str.chomp}<|"   ## remove newline (w/ chomp) in debug/echo output 
    str
  end
end


## our own code
require 'quik'
