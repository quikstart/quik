# encoding: utf-8

module Quik

class Package

  def initialize( key )   ## e.g. quikstart/gems
    if key.index( '/' ).nil?  ## if just 'gems' etc; assumbe quikstart "standard" github org
      @key = "quikstart/#{key}"
    else
      @key = key   # use as is e.g. seattlerb/hoe etc.
    end
  end


  def remote_zip_url # remote zip url
    "https://github.com/#{@key}/archive/master.zip"
  end

  def local_zip_name
    ## note: change / to --I-- for "flat" structure (e.g. no dirs)
    @key.sub( '/', '--I--' )   # note: will NOT include/return .zip extension
  end

  def local_zip_dir
    "."    ## use ./tmp or ./dl  or ~/.quik/cache  - why?? why not??
  end

  def local_zip_path # local zip path
    "#{local_zip_dir}/#{local_zip_name}.zip"
  end



  def download
    src      = remote_zip_url
    dest_zip = local_zip_path

    ## make sure dest folder exists
    FileUtils.mkdir_p( local_zip_dir ) unless Dir.exist?( local_zip_dir )
    fetch_archive( src, dest_zip )
  end

  def unzip( unzip_dir )
    src        = local_zip_path
    dest_unzip = unzip_dir ## local_unzip_dir

    ## check if folders exists? if not create folder in path
    FileUtils.mkdir_p( dest_unzip ) unless Dir.exist?( dest_unzip )
    unzip_archive( src, dest_unzip )
  end


  def merge( root_dir, hash )
    ## replace/merge variable in files
    Dir.chdir( "#{root_dir}" ) do
      files = Dir[ '**/*' ]   ## get all files
      pp files
    end
  end


private
  def fetch_archive( src, dest )
    ## step 1 - fetch archive
    worker = Fetcher::Worker.new
    worker.copy( src, dest )
    ### fix: add src.sha5
    ### inside folder
    ### lets us check if current HEAD version is in place across datafiles etc.
    ## - try HTTP HEAD ?? to check?
  end

  def unzip_archive( src, dest, opts={} )
    ### todo/fix: rename or remove root folder -- use opts { root: false or something??}
    # e.g
    # !/starter-gh-pages/_layouts/ becomes
    # !/_layouts/ etc.

    ##
    ## note:
    ##  skip all files in "root" folder
    ##   only unzip files in /template(s)/ folder

    Zip::File.open( src ) do |zipfile|
      zipfile.each do |file|
        if file.directory?
          puts " skip directory zip entry - #{file.name}"
        else
          ### fix: only cut-off if master or gh-pages ???
          ##  check if others include root folder?
          name = file.name[ file.name.index('/')+1..-1] ## cut-off root/first path entry

          ## note: name must start w/ template/ or templates/
          ##   otherwise gets skipped as "top level" docu
          if name =~ /^template(s)?\//
            name = name[ name.index('/')+1..-1] ## cut-off first path entry (e.g. template(s)/)

            path = File.join( dest, name)
            puts " unzip file zip entry - #{file.name} to #{path}"
            FileUtils.mkdir_p( File.dirname( path) )
            ## todo/fix: check - always overwrite if file exists - why? why not??
            zipfile.extract(file, path) unless File.exist?(path)
          else
            puts " skip top-level docu file entry - #{file.name}"
          end
        end
      end
    end
  end # method unzip_theme


end # class Package

end # module Quik

