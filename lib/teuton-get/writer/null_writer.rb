require_relative "writer"

class NullWriter < Writer
  def write(text = "", args = {})
    # Nothing
  end

  def writeln(text = "", args = {})
    # Nothing
  end

  def write_table(rows)
    # Nothing
  end
end
