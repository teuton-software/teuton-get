require "tty-table"
require_relative "writer"
require_relative "format"

class TerminalWriter < Writer
  attr_accessor :quiet

  def initialize
    @quiet = false
  end

  def write(text = "", args = {})
    print TeutonGet::Format.colorize(text, args[:color])
  end

  def writeln(text = "", args = {})
    write("#{text}\n", args)
  end

  def write_table(rows)
    table = TTY::Table.new(rows)
    puts table.render(:ascii)
  end
end
