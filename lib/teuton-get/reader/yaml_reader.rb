require "date"
require "yaml"
require_relative "reader"

class YamlReader < Reader
  def initialize(filepath = "")
    @filepath = filepath
  end

  def source
    @filepath
  end

  def read(filepath = :default)
    @filepath = filepath unless filepath == :default
    return {} unless File.exist? filepath

    content = File.open(filepath)
    # YAML.load(content)
    YAML.safe_load(
      content,
      permitted_classes: [Array, Date, Hash, Symbol]
    )
  end
end
