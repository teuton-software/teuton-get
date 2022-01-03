
require 'colorize'
require_relative 'writer'

class TerminalWriter < Writer
  def write(text ='', args = {})
    color = args[:color] || :white
    puts text.colorize(color)
  end
end
