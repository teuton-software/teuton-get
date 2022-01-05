
require 'yaml'
require_relative 'reader'

class YamlReader < Reader
  def source
  end

  def read(filepath)
    return {} unless File.exist? filepath
    YAML.load(File.open(filepath))
  end
end
