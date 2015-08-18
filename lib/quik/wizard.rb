# encoding: utf-8


## note:
##  use global $QUIK_WIZARD_STDIN
##    lets you redirect stdin for testing  e.g $QUIK_WIZARD_STDIN = StringIO.new( 'test/n' )
$QUIK_WIZARD_IN = $stdin


module Quik

module Wizard   ## use a different name e.g. WizardHelpers, FormHelpers, InputHelper, etc - why, why not??

def getstr  ## use getstr to avoid conflict w/ gets (use better name? read_string, readline (already exists too), etc.?)
  ## note: gets will include trailing newline (user hits return to enter data)
  ##   - use strip for now (remove leading and traling whitspaces) - might later just use chomp ? (jsut removes newlines)
  $QUIK_WIZARD_IN.gets.strip
end

def say( text )
  puts text
end


YES_REGEX = /y|yes|on|t|true/i      ## support YAML true values - double check (YAML does NOT support t/f)
NO_REGEX  = /n|no|off|f|false/i

def yes?( question )   ## defaults to yes - why, why not??
  ## todo: strip trailing question mark (?) if present (gets auto-included)
  print( "Q: #{question} (y/n)? [y]: " )
  str = getstr
  if str.empty? || str =~ YES_REGEX
    true
  elsif str =~ NO_REGEX
    false
  else    ## warn: unknown value??
    true
  end
end

def no?( question )   ## defaults to yes - why, why not??
  ## todo: strip trailing question mark (?) if present (gets auto-included)
  print( "Q: #{question} (y/n)? [n]: " )
  str = getstr
  if str.empty? || str =~ NO_REGEX
    true
  elsif str =~ YES_REGEX
    false
  else    ## warn: unknown value??
    true
  end
end


def ask( question, default=nil )
  ## todo: strip trailing question mark (?) if present (gets auto-included)
  if default
    print( "Q: #{question}? [#{default}]: " )
  else
    print( "Q: #{question}?: " )
  end

  str = getstr
  if default && str.empty?   ## todo: best way to check for empty string?
    str = default
  end
  str  
end


def select( title, options )
  puts( "Q: #{title}: " )
  options.each_with_index do |opt,i|
    puts "    #{i+1} - #{opt}"
  end
  print( "   Your choice (1-#{options.size})? [1]: " )
  str = getstr
  if str.empty?   ## todo: best way to check for empty string?
    num = 0   ## default to first option for now
  else
    num = str.to_i   ## note: defaults to 0 if cannot convert?
    num -= 1   if num > 0    ## note: "convert" from 1-based to 0-based for ary; if invalid entry; default to 0
  end
  options[ num ]
end

end # module Wizard
end # module Quik
