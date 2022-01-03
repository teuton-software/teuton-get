
require 'inifile'
require_relative '../application'

class IniFileReader
  def read()
    home = Application.instance.get('HOME')
    configfile = Application::CONFIGFILE
    inifile = IniFile.load("#{home}/.teuton/#{configfile}")
    data = {}
    inifile.sections.each do |section|
      data[section] = inifile[section]
    end
    data
  end
end
