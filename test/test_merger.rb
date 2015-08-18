# encoding: utf-8

###
# to run use
#   ruby -I ./lib -I ./test test/test_merger.rb


require 'helper'


class TestMerger < MiniTest::Test

  def test_gem_starter_template

    config = { 'filename' => 'hola' }

    m = Quik::Merger.new
    ## m.merge( './o/gem', config )

    flags = { verbose: true,
              noop:    true }
    m.merge_filenames( "#{Quik.root}/test/data/gem-starter-template", config, flags )
    ## m.merge_filenames( "./o/gem", config, verbose: true )

    assert true  ## if we get here; everything is ok
  end

end # class TestMerger
