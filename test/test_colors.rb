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
    puts "this text is magenta".magenta
    puts "this text is cyan".cyan

    puts "this text is blue".bold.blue
    puts "this text is red".bold.red
    puts "this text is green".bold.green + "this text is yellow".bold.yellow

    pp String.use_colors?

    assert true  ## if we get here; everything is ok
  end

  def test_codes
    assert_equal "\e[31mred\e[0m",                 "red".red
    assert_equal "\e[34m\e[31mblue\e[0m\e[0m",     "blue".red.blue
    ##  better to generate "\e[34m;[31m"  -- why? why not? e.g. one starting escpape and codes delimited by ; ??
    assert_equal "\e[1mway bold\e[0m",             "way bold".bold
    assert_equal "\e[36m\e[1mcyan bold\e[0m\e[0m", "cyan bold".bold.cyan
  end

end # class TestColors

