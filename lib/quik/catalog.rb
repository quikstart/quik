# encoding: utf-8

module Quik

class Catalog

  def self.from_url( src )
    worker = Fetcher::Worker.new
    text = worker.read_utf8!( src )
    self.from_string( text )
  end

  def self.from_file( path )
    ## read in themes catalog
    text  = File.open( path, 'r:utf-8' ) { |f| f.read }
    self.from_string( text )
  end

  def self.from_string( text )
    self.new( text )
  end


  def initialize( text )
    @scripts     = YAML.load( text )
  end

  def list( filter=nil )
    ## pp filter

    @scripts.each_with_index do |h,i|
      name    = h['name']
      summary = h['summary']

      line = ''
      line << "  %3d" % (i+1)
      line << "..%-10s" % name
      line << " .:.  #{summary}"

      if filter
        ## note: ignore case (upper/lower/downcase) for now
        ##  filter on name/title and
        ##            tags for now
        if name.downcase.index(filter.downcase)    != nil ||    ## note: 0 is match found on index 0; only nil is not found
           summary.downcase.index(filter.downcase) != nil
          puts line
        end
      else
        puts line
      end
    end
  end  # method filter

end # class Catalog

end # module Quik
