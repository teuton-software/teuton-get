
require 'inifile'
require_relative 'reader'

class IniFileReader < Reader
  def initialize(filepath = '')
    @filepath = filepath
  end

  def source
    @filepath
  end

  def read(filepath = :default)
    @filepath = filepath unless filepath == :default
    return {} unless File.exists? @filepath

    inifile = IniFile.load(@filepath)
    data = {}
    inifile.sections.each do |section|
      data[section] = inifile[section]
    end
    data
  end
end
