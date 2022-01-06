
require_relative 'writer'

class NulllWriter < Writer
  def write(text = '', args = {})
  end

  def writeln(text = '', args = {})
  end

  def write_table(rows)
  end
end
