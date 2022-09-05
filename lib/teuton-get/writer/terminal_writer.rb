require "colorize"
require "pastel"
require "tty-table"
require_relative "writer"

class TerminalWriter < Writer
  COLORS = [:red, :green, :yellow, :blue, :magenta, :cyan, :white]
  def write(text = "", args = {})
    color = args[:color] || :silver
    print colorize_text(color, text)
  end

  def writeln(text = "", args = {})
    write("#{text}\n", args)
  end

  def write_table(rows)
    table = TTY::Table.new(rows)
    # puts table.render(:basic)
    puts table.render(:ascii)
  end

  def colorize_text(color, text)
    text.colorize(color)
  end
end
