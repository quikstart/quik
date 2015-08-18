# encoding: utf-8

###
# to run use
#   ruby -I ./lib -I ./test test/test_package.rb


require 'helper'


class TestPackage < MiniTest::Test

  def test_gem_starter_template

    pak = Quik::Package.new( 'gem-starter-template' )
    pak.download
    pak.unzip( './o/gem' )

    assert true  ## if we get here; everything is ok
  end

end # class TestPackage
