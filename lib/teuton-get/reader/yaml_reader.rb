
require 'yaml'
require_relative 'reader'

class YamlReader < Reader
  def read(filepath)
    YAML.load(File.open(filepath))
  end
end
