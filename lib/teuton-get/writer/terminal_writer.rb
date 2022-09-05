require "colorize"
require "tty-table"
require_relative "writer"

class TerminalWriter < Writer
  COLORS = [:blue, :magenta, :cyan, :red, :green, :yellow]
  def write(text = "", args = {})
    color = if args[:color].nil?
      :silver
    elsif args[:color].instance_of? Integer
      COLORS[args[:color]]
    elsif args[:color].instance_of? Symbol
      args[:color]
    else
      :silver
    end
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
