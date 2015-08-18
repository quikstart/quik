#encoding: utf-8

module Quik

##
# used for config block
#   lets you access props (even nested) that don't yet exist
#    and all props get stored in a hash
#
#  e.g
#  c = OpenConfig.new
#  c.title        = 'title'
#  c.author.name  = 'name'

#  c.quik.last_updated = Time.now
#  c.quik.title        = 'title'
#  c.quik.name         = 'name'
#  c.quik.theme        = 'theme'

class OpenConfig

  def initialize
    @h = {}
  end

  def to_h
    h = {}
    @h.each do |k,v|
      if v.is_a? OpenConfig
        h[ k ] = v.to_h
      else
        h[ k ] = v  ## just pass along as is
      end
    end
    h
  end

  def method_missing( m, *args, &block)
    if m.to_s =~ /^(.*)=$/   ## setter
      puts "config lookup (setter) >#{m}< #{m.class.name}, #{args.inspect}"
      key = m[0..-2].to_s  ## cut off trailing =
      @h[ key ] = args[0].to_s    # note: assume first arg is value for setter
                                # note: for now all values are strings (always use to_s)
    else       ## assume getter
      ## fix: add check for args??  must be 0 for getters??
      ##       use else super to delegate non-getters??
      puts "config lookup (getter) >#{m}< #{m.class.name}"
      key = m.to_s
      value = @h[ key ]
      if value.nil?
        puts "  config add (nested) hash"
        value = @h[ key ] = OpenConfig.new
      end
      value
    end  
  end # method_missing

end # class OpenConfig
   
end  # module Quik
