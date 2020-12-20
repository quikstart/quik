#encoding: utf-8

module Quik

class Builder

  def self.load_file( path, opts={} )
    code = File.open( path, 'r:utf-8' ) { |f| f.read }
    self.load( code, opts )
  end

  def self.load( code, opts={} )
    builder = Builder.new( opts )
    builder.instance_eval( code )
    builder
  end


  include Wizard   ## mixin helpers for say, ask, yes?, no?, select, etc.

  def initialize( opts={} )
    puts "==> starting new Quik script with options #{opts.inspect}; lets go"

    @test       = opts[:dry_run] || opts[:test] || false
    @output_dir = opts[:o] || '.'
    @pak        = nil   ## for now reference last template pack (in future support many - why?? why not??)
  end

  ## "global" builder options
  def test?()      @test;       end   ## dry_run option (defaults to false)
  def output_dir() @output_dir; end   ## ouptput (root) dir (defaults to . e.g. working folder)



  def use( name, opts={} )  ## short alias for install_template
    install_template( name, opts )
  end

  def install_template( name, opts= {} )
    puts "==> handle install_template >#{name}< with options #{opts.inspect}"

    ## note for now assume name is key
    ##   e.g. always downcase (e.g. Gem => gem)
    key = name.downcase

    if test?
      # do nothing; dry run
    else
      @pak = Package.new( key )

      puts "GET #{@pak.remote_zip_url}".bold.green   ## output network access in green bold
      @pak.download
      ##  pak.unzip( "#{@output_dir}/#{key}" )
    end
  end


  def config( opts={} )
    puts "==> handle config block"
    c = OpenConfig.new
    yield( c )
    ## pp c
    h = c.to_h

    pp h

    ##
    # check for name
    ##  required for output
    ##  if no name
    ##  use ./ working folder for output!!!

    name = h['name']

    if name.nil? || name.empty?
      fail 'sorry; for now name is required for output folder'
    end

    if test?
      ## do nothing; dry run
    else
      if @pak
        unzip_dir = "./#{name}"
        ## step 1: unzip templates
        @pak.unzip( unzip_dir )
        ## step 2: merge templates (using hash/config settings)
        m = Quik::Merger.new
        m.merge( unzip_dir, h )
      end
    end
  end # method config


end # class Builder

end # module Quik
