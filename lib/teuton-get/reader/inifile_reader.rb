
require 'inifile'

class IniFileReader
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
