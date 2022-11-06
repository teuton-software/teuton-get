require "fileutils"
require_relative "../application"
require_relative "../reader/inifile_reader"
require_relative "../utils/format"
require_relative "../writer/terminal_writer"

# Create Teuton Repo config file
class RepoConfig
  attr_reader :data

  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
    @dev = args[:progress_writer]

    @config_dirpath = args[:config_dirpath] || ""
    @config_filepath = File.join(@config_dirpath, Application::CONFIGFILE)
  end

  def self.new_by_default
    config_filepath = Application.instance.get(:config_filepath)

    RepoConfig.new(
      config_reader: IniFileReader.new(config_filepath),
      progress_writer: TerminalWriter.new,
      config_dirpath: Application.instance.get(:config_dirpath)
    )
  end

  def create
    @dev.writeln "\n==> Creating configuration files"
    create_dir
    create_ini_file
  end

  def show_list
    rows = []
    rows << ["E", "NAME", "DESCRIPTION"]
    rows << :separator

    index = 0
    @data.each_pair do |key, value|
      enable = "\u{2714}"
      enable = " " unless value["enable"]
      description = value["description"] || "?"
      rows << [enable, TeutonGet::Format.colorize(key, index), description]
      index += 1
    end
    @dev.writeln "Repository list"
    @dev.write_table(rows)
    @dev.write "Config: "
    @dev.writeln "#{@reader.source}\n", color: :white
  end

  private

  def create_dir
    dirpath = @config_dirpath
    if Dir.exist? dirpath
      @dev.write "    \u{2716} Exists dir!      : ", color: :white
      @dev.writeln dirpath, color: :white
    else
      begin
        FileUtils.mkdir_p(dirpath)
        @dev.write "    \u{2714} Create dir       : ", color: :white
        @dev.writeln dirpath, color: :green
      rescue => e
        @dev.write "    \u{2716} Create dir  ERROR: "
        @dev.writeln dirpath, color: :red
        puts e
      end
    end
  end

  def create_ini_file
    src = File.join(File.dirname(__FILE__), "..", "files", Application::CONFIGFILE)
    copyfile(src, @config_filepath)
  end

  def copyfile(target, dest)
    if File.exist? dest
      @dev.write "    \u{2716} Exists file!     : ", color: :white
      @dev.writeln dest, color: :white
      return true
    end
    begin
      FileUtils.cp(target, dest)
      @dev.write "    \u{2714} Create file      : ", color: :white
      @dev.writeln dest, color: :green
    rescue => e
      @dev.write "    \u{2716} Create file ERROR: "
      @dev.writeln dest, color: :red
      puts e
    end
  end
end
