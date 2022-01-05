
require 'yaml'
require_relative 'reader'

class YamlReader < Reader
  def initialize(filepath = '')
    @filepath = filepath
  end

  def source
    @filepath
  end

  def read(filepath = :default)
    @filepath = filepath unless filepath == :default
    return {} unless File.exist? filepath

    YAML.load(File.open(filepath))
  end
end
