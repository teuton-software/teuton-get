
require_relative 'writer'

class FileWriter < Writer
  def open(filepath)
    @file = File.open(filepath, 'w')
  end

  def write(text)
    @file.write text
  end

  def writeln(text)
    @file.write text
  end

  def close
    @file.close
  end
end
