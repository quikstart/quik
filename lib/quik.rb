# encoding: utf-8

# stdlibs
require 'pp'
require 'fileutils'
require 'yaml'
require 'json'
require 'uri'
require 'time'
require 'date'


# 3rd party libs/gems
require 'fetcher'

## more 3rd party gems
require 'zip'      # use $ gem install rubyzip
require 'gli'


# our own code
require 'quik/version'   # let version always go first


module Quik
  ### builtin default urls
  QUIK_SCRIPTS_URL = "https://github.com/quikstart/scripts/raw/master/scripts.yml"
end



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
  def self.main( args=ARGV )
    exit Tool.new.run( args )
  end
end # module Quik




## say hello
puts Quik.banner   if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
