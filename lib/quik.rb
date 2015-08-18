# encoding: utf-8

# stdlibs
require 'pp'
require 'fileutils'

# 3rd party libs/gems
require 'fetcher'
require 'zip'    ## e.g. use $ gem install rubyzip

# our own code
require 'quik/version'   # let version always go first
require 'quik/package'
require 'quik/merger'




## say hello
puts Quik.banner   if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
