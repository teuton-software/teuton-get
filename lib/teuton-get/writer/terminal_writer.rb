
require 'colorize'
require 'terminal-table'
require_relative 'writer'

class TerminalWriter < Writer
  def write(text = '', args = {})
    color = args[:color] || :silver
    print text.colorize(color)
  end

  def writeln(text = '', args = {})
    write("#{text}\n", args)
  end

  def write_table(rows)
    puts Terminal::Table.new :rows => rows
  end
end
