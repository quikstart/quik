# encoding: utf-8

module Quik

class Merger



  def find_files( root_dir )
    tree = []

    files =  Dir.entries( root_dir )
    files = files.sort
    puts "#{root_dir}:"
    pp files

    files.each do |file|
      if File.directory?( "#{root_dir}/#{file}" )
        ## note: skip directory if it starts with dot e.g. . or .. or .git etc.
        if file.start_with?( '.' )
          puts "skipping directory >#{file}< (#{root_dir})"
          next
        end
        subtree = find_files( "#{root_dir}/#{file}" )
        tree << [ file, subtree ]
      else
        ## just a "regular" file
        tree << file
      end
    end
    tree
  end


  def merge_filenames( root_dir, hash, opts={} )  ## flags e.g. noop, verbose, etc. see FileUtils
    tree = find_files( root_dir )
    pp tree

    flags = {     ## always use verbose mode for now
      verbose: true
    }

    ## todo/check: move opts={} to initialize e.g. Merger.new( opts={}) why? why not??

    ## check for noop e.g. test mode/dry run
    flags[ :noop ] = true  if opts[:test] || opts[:dry_run] || opts[:noop]

    puts "walk tree:"
    merge_filenames_worker_step1( root_dir, hash, tree, flags )
    merge_filenames_worker_step2( root_dir, hash, tree, flags )
  end

  def merge_filenames_worker_step1( root_dir, hash, tree, flags )
    ## note:  step 1 move all files
    ##        step 2 move all dirs

    tree.each do |node|
      if node.is_a? Array ## assume it's a directory
        merge_filenames_worker_step1( "#{root_dir}/#{node[0]}", hash, node[1], flags )
      else  ## assume it's a file
        old_name = node
        new_name = merge_path( old_name, hash )
        if old_name == new_name
           puts "  keep file #{node} (#{root_dir})"
        else
           puts "  *** move file #{old_name} => #{new_name} (#{root_dir})"
           src_path  = "#{root_dir}/#{old_name}"
           dest_path = "#{root_dir}/#{new_name}"
           FileUtils.mv( src_path, dest_path, flags )
        end
      end
    end
  end

  def merge_filenames_worker_step2( root_dir, hash, tree, flags )
    ## note:  step 1 move all files
    ##        step 2 move all dirs

    tree.each do |node|
      if node.is_a? Array ## assume it's a directory
        merge_filenames_worker_step2( "#{root_dir}/#{node[0]}", hash, node[1], flags )
        old_name = node[0]
        new_name = merge_path( old_name, hash )
        if old_name == new_name
           puts "  keep dir #{node[0]} (#{root_dir})"
        else
           puts "  *** move dir #{old_name} => #{new_name} (#{root_dir})"
           src_path  = "#{root_dir}/#{old_name}"
           dest_path = "#{root_dir}/#{new_name}"
           FileUtils.mv( src_path, dest_path, flags )
        end
      end
    end
  end



  def merge_files( root_dir, hash, opts={} )
    ## note: rescan files (after renames)
    tree = find_files( root_dir )
    pp tree

    puts "walk tree:"
    merge_files_worker( root_dir, '', hash, tree, opts )
  end

  def merge_files_worker( root_dir, relative_dir, hash, tree, opts )
    tree.each do |node|
      if node.is_a? Array ## assume it's a directory
        if relative_dir.empty?   # e.g. just add w/o leading slash e.g. 'lib' and not '/lib'
          new_relative_dir = node[0].dup  # note: create a new string; just in case
        else
          new_relative_dir = "#{relative_dir}/#{node[0]}"
        end
        merge_files_worker( root_dir, new_relative_dir, hash, node[1], opts )
      else  ## assume it's a file
        if relative_dir.empty?
          relative_path = node
        else
          relative_path = "#{relative_dir}/#{node}"
        end

        src_path = "#{root_dir}/#{relative_path}"
        
        ## note: for now assume always assume text files/utf8
        ##  fix: change to File.read_utf8 ??
        old_text = File.read( src_path )
        new_text = merge_text( old_text, hash )

        if opts[:o]
          dest_root = opts[:o]
          dest_path = "#{dest_root}/#{relative_path}"
          ## make sure dest_path exists
          dest_dir = File.dirname( dest_path )
          FileUtils.mkdir_p( dest_dir ) unless Dir.exists?( dest_dir )
        else
          dest_root = root_dir
          dest_path = "#{dest_root}/#{relative_path}"
        end

        if old_text == new_text
           if opts[:o]  ## for testing copy file 1:1
             puts "  copy file 1:1 #{node} (#{relative_dir}) in (#{dest_root})"
             FileUtils.cp( src_path, dest_path, verbose: true )
           else
             puts "  skip file #{node} (#{relative_dir})"
           end
        else
           puts "  *** update file #{node} (#{relative_dir}) in (#{dest_root})"
           File.open( dest_path, 'w' ) do |f|
             f.write new_text
           end
        end
      end
    end
  end



  def merge_path( path, hash )
    ## e.g. allow
    ##  __filename__  or
    ##  $filename$   for now
    ##   note: allow underline too  e.g $file_name$ etc.
    path.gsub( /(__|\$)([a-z_]+)\1/i ) do |_|
      key   = $2.to_s
      value = hash[ key ]
      puts "   [path] replacing #{key} w/ >#{value}< in (#{path})"
      value
    end
  end

  def merge_text( text, hash )
    ## e.g. allow
    ##  $filename$  for now only in text
    ##  note: must include leading and trailing word boundry (/B)
    ##   e.g. hello$test$ will not match only "free-standing $test
    ##  or in quote e.g. "$test$"
    ##  e.g. no letters or digits allowed before or after $ to match
    ##  note: allow underline too e.g. $test_klass$ etc.

    ## pp text

    text.gsub( /\B\$([a-z_]+)\$\B/i ) do |_|
      key   = $1.to_s
      value = hash[ key ]
      puts "   [text] replacing #{key} w/ >#{value}<"
      value
    end
  end



  def merge( root_dir, hash, opts={} )
    puts "  merge #{root_dir}, #{hash.inspect}"

    merge_filenames( root_dir, hash, opts )
    merge_files( root_dir, hash, opts )
  end

end # class Merger

end # module Quik

