require_relative "writer"
require "fileutils"

class FileWriter < Writer
  def open(filepath)
    dirpath =  File.dirname(filepath)
    FileUtils.mkdir_p(dirpath) unless Dir.exist? dirpath
    @file = File.open(filepath, "w")
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
