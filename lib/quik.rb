# encoding: utf-8


# 3rd party libs/gems
require 'fetcher'
require 'zip'    ## e.g. use $ gem install rubyzip

# our own code

require 'quik/version'   # let version always go first
require 'quik/package'




## say hello
puts Quik.banner   if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
