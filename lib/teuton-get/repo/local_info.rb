require_relative "../application"
require_relative "../writer/terminal_writer"
require_relative "../reader/yaml_reader"
require "erb"
require "tty-prompt"

# Create metadata for local user teuton test
class LocalInfo
  def initialize(dev = TerminalWriter.new)
    @dev = dev
    @data = {}
  end

  def default_create(testpath)
    set_default_data(testpath)
    create(testpath)
  end

  def user_create(testpath)
    ask_data(testpath)
    create(testpath)
  end

  def read(filepath)
    dirpath = File.dirname(filepath)
    @dev.writeln "    Reading #{dirpath}"
    data = YamlReader.new(filepath).read

    filepaths = Dir.glob("#{dirpath}/**/*.*")
    files = filepaths.map { |i| i[dirpath.size + 1, i.size] }
    data["files"] = files
    data
  end

  private

  def set_default_data(testpath)
    @data[:name] = File.basename(testpath)
    @data[:author] = ENV["USER"]
    @data[:date] = Time.now.strftime("%Y-%m-%d")
    @data[:desc] = "Write your description"
    @data[:tags] = ["Write your", "comma separated", "tags"]
  end

  def ask_data(testpath)
    set_default_data(testpath)
    prompt = TTY::Prompt.new
    @data[:name] = prompt.ask("name?", default: @data[:name])
    @data[:author] = prompt.ask("author?", default: @data[:author])
    @data[:date] = prompt.ask("date?", default: @data[:date])
    @data[:desc] = sanityze(prompt.ask("desc?", default: @data[:desc]))
    input = prompt.ask("tags?", default: @data[:tags].join(","))
    @data[:tags] = input.split(",")
  end

  def create(testpath)
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

  def sanityze(text)
    text.tr(":", " ")
  end
end
