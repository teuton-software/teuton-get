
require 'inifile'
require_relative 'reader'

class IniFileReader < Reader
  def initialize(filepath)
    @filepath = filepath
  end

  def read()
    inifile = IniFile.load(@filepath)
    data = {}
    inifile.sections.each do |section|
      data[section] = inifile[section]
    end
    data
  end
end
