# encoding: utf-8

# stdlibs
require 'pp'
require 'fileutils'
require 'yaml'
require 'uri'

# 3rd party libs/gems
require 'fetcher'
require 'textutils' ## used for File.read_utf8

## more 3rd party gems
require 'zip' # use $ gem install rubyzip
require 'gli'


# our own code
require 'quik/version'   # let version always go first
require 'quik/catalog'
require 'quik/package'
require 'quik/merger'
require 'quik/config'
require 'quik/wizard'
require 'quik/builder'
require 'quik/colors'


require 'quik/cli/opts'
require 'quik/cli/main'


module Quik
  def self.main
    exit Tool.new.run( ARGV )
  end
end # module Quik


## say hello
puts Quik.banner   if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG


Quik.main if __FILE__ == $0
