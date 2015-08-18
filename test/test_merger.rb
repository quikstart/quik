# encoding: utf-8

###
# to run use
#   ruby -I ./lib -I ./test test/test_merger.rb


require 'helper'


class TestMerger < MiniTest::Test

  def test_gem_starter_template

    config = { 'filename' => 'hola',
               'version' => '0.0.1',
               'klass'  => 'Hola',
             }

    m = Quik::Merger.new

    ## m.merge_filenames( "#{Quik.root}/test/data/gem-starter-template", config, test: true )
    ## m.merge_filenames( "./o/gem", config )

    ## note: set  output path (for testing; not in place)
    ## m.merge_files( "#{Quik.root}/test/data/gem-starter-template", config, test: true, o: "./o/#{Time.now.to_i}" )

    ## note: set  output path (for testing; not in place)
    m.merge( "#{Quik.root}/test/data/gem-starter-template", config, test: true, o: "./o/#{Time.now.to_i}" )
    ## m.merge( "./o/gem", config )

    assert true  ## if we get here; everything is ok
  end

end # class TestMerger
