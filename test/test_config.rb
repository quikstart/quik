# encoding: utf-8

###
# to run use
#   ruby -I ./lib -I ./test test/test_config.rb


require 'helper'


class TestConfig < MiniTest::Test

  def test_config

    c = Quik::OpenConfig.new
    c.title        = 'title'
    c.author.name  = 'name'

    c.mrhyde.last_updated = Time.now
    c.mrhyde.title        = 'title'
    c.mrhyde.name         = 'name'
    c.mrhyde.theme        = 'theme'
    c.mrhyde.meta.info    = 'test nested nested value'
    
    ## test self reference in value assignment e.g.
    c.test.title  = c.title
    c.test.name   = c.author.name

    pp c.to_h

    assert true  ## if we get here; everything is ok
  end


end # class TestConfig
