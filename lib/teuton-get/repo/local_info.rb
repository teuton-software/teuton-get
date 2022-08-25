require_relative "../application"
require_relative "../writer/terminal_writer"
require "erb"

class LocalInfo
  def initialize(dev = TerminalWriter.new)
    @dev = dev
  end

  def create_info(testpath)
    @dev.write "\n==> Create info for "
    @dev.writeln testpath, color: :light_cyan

    startfile = File.join(testpath, "start.rb")
    unless File.exist?(startfile)
      @dev.writeln "    ERROR: File start.rb not found!", color: :light_red
      return false
    end

    infofilename = Application::INFOFILENAME
    targetpath = File.join(testpath, infofilename)
    sourcepath = File.join(File.dirname(__FILE__), "..", "files", infofilename)
    filepaths = Dir.glob("#{testpath}/**/*.*")
    _files = filepaths.map { |i| i[testpath.size + 1, i.size] } - ["tt-info.yaml"]

    template = File.read(sourcepath)
    content = ERB.new(template, trim_mode: "%>")
    File.write(targetpath, content.result(binding))
    true
  end
end
