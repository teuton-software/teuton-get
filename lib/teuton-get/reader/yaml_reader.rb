
require 'yaml'

class YamlReader
  def read(filepath)
    YAML.load(File.open(filepath))
  end
end
