# encoding: utf-8

###
# to run use
#   ruby -I ./lib -I ./test test/test_colors.rb


require 'helper'


class TestColors < MiniTest::Test

  def test_colors

    puts "this text is blue".blue
    puts "this text is red".red
    puts "this text is green".green + "this text is yellow".yellow

    pp String.use_colors?

    assert true  ## if we get here; everything is ok
  end

end # class TestColors
