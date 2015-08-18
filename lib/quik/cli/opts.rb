# encoding: utf-8

module Quik

class Opts

  def merge_gli_options!( options = {} )
    @test    = true     if options[:test]    == true
    @verbose = true     if options[:verbose] == true
  end


  def verbose=(boolean)   # add: alias for debug ??
    @verbose = boolean
  end

  def verbose?
    return false if @verbose.nil?   # default verbose/debug flag is false
    @verbose == true
  end

  def test=(boolean)
    @test = boolean
  end

  def test?
    return false if @test.nil?   # default test/dry-run flag is false
    @test == true
  end

end # class Opts

end # module Quik
