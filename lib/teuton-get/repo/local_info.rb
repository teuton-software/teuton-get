require_relative "../application"
require_relative "../writer/terminal_writer"
require_relative "../reader/yaml_reader"
require "erb"

class LocalInfo
  def initialize(dev = TerminalWriter.new)
    @dev = dev
    @data = {}
  end

  def fill_data(testpath, items = :default)
    @data[:name] = File.basename(testpath)
    @data[:author] = ENV["USER"]
    @data[:date] = Time.now.strftime("%Y-%m-%d")
  end

  def create(testpath)
    fill_data(testpath, :default)

    startfile = File.join(testpath, "start.rb")
    unless File.exist?(startfile)
      @dev.writeln "    ERROR: File start.rb not found!", color: :light_red
      return false
    end

    infofilename = Application::INFOFILENAME
    sourcepath = File.join(File.dirname(__FILE__), "..", "files", infofilename)
    template = File.read(sourcepath)
    content = ERB.new(template, trim_mode: "%>")
    targetpath = File.join(testpath, infofilename)
    File.write(targetpath, content.result(binding))

    true
  end

  def read(filepath)
    YamlReader.new(filepath).read
  end
end
