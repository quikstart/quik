################
## NOTE: wrap gli config into a class
##        see github.com/davetron5000/gli/issues/153

module Quik

class Tool
  def initialize
    LogUtils::Logger.root.level = :info   # set logging level to info
  end

  def run( args )
    puts Quik.banner
    Toolii.run( args )
  end
end


## NOTE: gli added function are class methods (thus, wrap class Toolii in Tool for now)

class Toolii
  extend GLI::App

  def self.logger=(value) @@logger=value; end
  def self.logger()       @@logger; end

  ## todo: find a better name e.g. change to settings? config? safe_opts? why? why not?
  def self.opts=(value)  @@opts = value; end
  def self.opts()        @@opts; end


logger = LogUtils::Logger.root
opts   = Opts.new


program_desc 'ruby quick starter template script wizard .:. the missing code generator'
version VERSION


## desc 'Use only local (offline) cached data; no (online) remote network access'
## switch [:l, :local], negatable: false

desc '(Debug) Show debug messages'
switch [:verbose], negatable: false    ## todo: use -w for short form? check ruby interpreter if in use too?

desc '(Debug) Dry run; run script in simulation for testing'
switch [:test, :dry_run], negatable: false



def self.fetch_catalog
  ## scripts_dir = "#{Quik.root}/test/data"
  ## catalog    = Catalog.new( "#{scripts_dir}/scripts.yml" )

  url = QUIK_SCRIPTS_URL

  puts "GET #{url}".bold.green   ## output network access in green bold

  catalog = Catalog.from_url( url )
  catalog
end


def self.fetch_script( name_or_path )

  ## first try local version in working folder

  text = ''

  extname = File.extname( name_or_path )


  ## try local first
  ##   todo/fix:  check in ~/.quik/ dir too?

  path =  if extname == '.rb' && File.exist?( name_or_path )
            name_or_path
          elsif extname == '' && File.exist?( "#{name_or_path}.rb" )
            "#{name_or_path}.rb"
          elsif extname == '' && File.exist?( "~/.quik/#{name_or_path}.rb" )
            "~/.quik/#{name_or_path}.rb"   ## todo/check - if (~) shortcut works in windows -too?
          else
            nil
          end

  if path
    text = File.open( path, 'r:utf-8' ) { |f| f.read }
  else  ## try fetch remote script

    url = nil

    if name_or_path.index( '/' ).nil?   ## assume short-cut name if no (/) in name
        ## do a lookup from catalog!!!
        catalog = fetch_catalog
        rec = catalog.find( name_or_path )
        url = rec['script']  if rec

        if url.nil?
            puts "!! ERROR - sorry no wizard script found / available for name >#{name_or_path}<"
            exit 1
        end
    else
        ## assume custom github url shortcut
        url = "https://github.com/#{name_or_path}/raw/master/quik.rb"
    end

    ## assume utf8 text encoding for now
    puts "GET #{url}".bold.green   ## output network access in green bold

    worker = Fetcher::Worker.new
    text = worker.read_utf8!( url )
  end

  text
end



desc "List ruby quick starter scripts"
arg_name 'QUERY'   # optional search query/filter
command [:list,:ls,:l] do |c|

  c.action do |g,o,args|
    ## read in scripts diretory
    catalog = fetch_catalog
    catalog.list( args[0] )   ## note: pass in filter e.g. args[0]; may be nil (no filter)
    puts 'Done.'
  end # action
end  # command list


desc "Run ruby quick starter script"
arg_name 'NAME'   # required theme name
command [:new,:n] do |c|

  c.action do |g,o,args|

    name = args[0] || 'gem'

    script = fetch_script( name )
    if opts.test?
      puts "dry (test) run:"
      Builder.load( script, test: true )
    else
      Builder.load( script )
    end

    puts 'Done.'
  end # action
end  # command setup



desc '(Debug) Test command suite'
command :test do |c|
  c.action do |g,o,args|

    puts "hello from test command"
    puts "args (#{args.class.name}):"
    pp args
    puts "o (#{o.class.name}):"
    pp o
    puts "g (#{g.class.name}):"
    pp g

    LogUtils::Logger.root.debug 'test debug msg'
    LogUtils::Logger.root.info 'test info msg'
    LogUtils::Logger.root.warn 'test warn msg'

    puts 'Done.'
  end
end



pre do |g,c,o,args|
  opts.merge_gli_options!( g )
  opts.merge_gli_options!( o )

  puts Quik.banner

  if opts.verbose?
    LogUtils::Logger.root.level = :debug
  end

  logger.debug "Executing #{c.name}"
  true
end

post do |global,c,o,args|
  logger.debug "Executed #{c.name}"
  true
end


on_error do |e|
  puts
  puts "*** error: #{e.message}"

  if opts.verbose?
    puts e.backtrace
  end

  false # skip default error handling
end


### exit run(ARGV)  ## note: use Toolii.run( ARGV ) outside of class

end  # class Toolii

end # module Quik

