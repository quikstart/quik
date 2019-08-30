# encoding: utf-8

### todo: move to textutils for (re)use - why? why not??
###   todo add some references to alternative color gems
##
##  e.g. https://github.com/fazibear/colorize
##       http://github.com/ssoroka/ansi
##       http://flori.github.com/term-ansicolor/
##       http://github.com/sickill/rainbow
##       https://github.com/janlelis/paint


## move to core_ext.rb - why? why not??

###
## fix: use css style
##  e.g. color( :red )
##       color( :blue )
##       background_color( :red )
##       font_style( :bold )  -- why? why not??

class String

  def self.use_colors?
    @@use_color ||=  true
    ##  todo/fix: check for windows on load (set to false;otherwise true)
    @@use_color
  end

  def self.use_colors=(value)
    @@use_color = value
  end


  def red()      colorize(31); end
  def green()    colorize(32); end
  def yellow()   colorize(33); end   ## note: more brown-ish (if not used w/ bold/bright mode) ??
  def blue()     colorize(34); end
  def magenta()  colorize(35); end   ## pink ??
  def cyan()     colorize(36); end   ## light blue ?? 

  def bold()     colorize(1); end    ## just use 0 clear for now; instead of BOLD_OFF (22) code; use bright as an alias??

private
  def colorize(code)
    if self.class.use_colors?
      "\e[#{code}m#{self}\e[0m"
    else
      self
    end
  end


   ## todo - add modes e.g. bold/underscore/etc.
=begin
class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def brown;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
def gray;           "\e[37m#{self}\e[0m" end

def on_black;       "\e[40m#{self}\e[0m" end
def on_red;         "\e[41m#{self}\e[0m" end
def on_green;       "\e[42m#{self}\e[0m" end
def on_brown;       "\e[43m#{self}\e[0m" end
def on_blue;        "\e[44m#{self}\e[0m" end
def on_magenta;     "\e[45m#{self}\e[0m" end
def on_cyan;        "\e[46m#{self}\e[0m" end
def on_gray;        "\e[47m#{self}\e[0m" end

def bold;           "\e[1m#{self}\e[21m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
def reverse_color;  "\e[7m#{self}\e[27m" end

use Ansi constants - why? why not? e.g.:
//foreground color
public static final String BLACK_TEXT()   { return "\033[30m";}
public static final String RED_TEXT()     { return "\033[31m";}
public static final String GREEN_TEXT()   { return "\033[32m";}
public static final String BROWN_TEXT()   { return "\033[33m";}
public static final String BLUE_TEXT()    { return "\033[34m";}
public static final String MAGENTA_TEXT() { return "\033[35m";}
public static final String CYAN_TEXT()    { return "\033[36m";}
public static final String GRAY_TEXT()    { return "\033[37m";}

//background color
public static final String BLACK_BACK()   { return "\033[40m";}
public static final String RED_BACK()     { return "\033[41m";}
public static final String GREEN_BACK()   { return "\033[42m";}
public static final String BROWN_BACK()   { return "\033[43m";}
public static final String BLUE_BACK()    { return "\033[44m";}
public static final String MAGENTA_BACK() { return "\033[45m";}
public static final String CYAN_BACK()    { return "\033[46m";}
public static final String WHITE_BACK()   { return "\033[47m";}

//ANSI control chars
public static final String RESET_COLORS() { return "\033[0m";}
public static final String BOLD_ON()      { return "\033[1m";}
public static final String BLINK_ON()     { return "\033[5m";}
public static final String REVERSE_ON()   { return "\033[7m";}
public static final String BOLD_OFF()     { return "\033[22m";}
public static final String BLINK_OFF()    { return "\033[25m";}
public static final String REVERSE_OFF()  { return "\033[27m";}
end

Code 	Effect
0 	Turn off all attributes
1 	Set bright mode
4 	Set underline mode
5 	Set blink mode
7 	Exchange foreground and background colors
8 	Hide text (foreground color would be the same as background)
30 	Black text
31 	Red text
32 	Green text
33 	Yellow text
34 	Blue text
35 	Magenta text
36 	Cyan text
37 	White text
39 	Default text color
40 	Black background
41 	Red background
42 	Green background
43 	Yellow background
44 	Blue background
45 	Magenta background
46 	Cyan background
47 	White background
49 	Default background color

note:
puts "\e[31m" # set format (red foreground)
puts "\e[0"   # clear format
puts "green-#{"red".red}-green".green # will be green-red-normal, because of \e[0
e.g. for now colors can NOT get nested
     plus if you bold/italic/etc. use it before the color e.g.
      bold.red etc.
=end


end # class String
