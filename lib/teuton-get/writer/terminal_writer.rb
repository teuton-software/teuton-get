
require 'colorize'
require_relative 'writer'

class TerminalWriter < Writer
  def write(text ='', args = {})
    color = args[:color] || :silver
    puts text.colorize(color)
  end
end
