# encoding: utf-8

module Quik

class Merger

  def initialize( opts={} )
    @opts = opts
  end


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


  def merge_filenames( root_dir, hash, flags )  ## flags e.g. noop, verbose, etc. see FileUtils
    tree = find_files( root_dir )
    pp tree

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

  def merge( root_dir, hash )
    puts "  merge #{root_dir}, #{hash.inspect}"

    ## output path (for testing; not in place)
    o = "./o/#{Time.now.to_i}"
  end


  def merge_path( file, hash )
    ## e.g. allow
    ##  __filename__  or
    ##  $filename$   for now
    file.gsub( /(__|\$)([a-z]+)\1/i ) do |_|
      key   = $2.to_s
      value = hash[ key ]
      puts "   replacing #{key} w/ >#{value}< in (#{file})"
      value
    end
  end


end # class Merger

end # module Quik

