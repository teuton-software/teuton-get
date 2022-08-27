require "colorize"
require "tty-table"
require_relative "writer"

class TerminalWriter < Writer
  def write(text = "", args = {})
    color = args[:color] || :silver
    print text.colorize(color)
  end

  def writeln(text = "", args = {})
    write("#{text}\n", args)
  end

  def write_table(rows)
    table = TTY::Table.new(rows)
    # puts table.render(:basic)
    puts table.render(:ascii)
  end
end
