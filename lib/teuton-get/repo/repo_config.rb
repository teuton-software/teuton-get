require "fileutils"
require_relative "../application"

class RepoConfig
  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
    @dev = args[:progress_writer]

    @config_dirpath = args[:config_dirpath] || ""
    @config_filepath = File.join(@config_dirpath, Application::CONFIGFILE)
  end

  def create
    @dev.writeln "\nCreating configuration files"
    create_dir
    create_ini_file
  end

  def show_list
    rows = []
    rows << ["E", "NAME", "DESCRIPTION", "TOTAL"]
    rows << :separator

    @data.each_pair do |key, value|
      enable = ""
      enable = "X" unless value["enable"]
      description = value["description"] || "?"
      total = value["total"] || 0
      rows << [enable, key, description, total]
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
      @dev.write "  * Exists dir!      : "
      @dev.writeln dirpath, color: :yellow
    else
      begin
        FileUtils.mkdir_p(dirpath)
        @dev.write " => Create dir       : "
        @dev.writeln dirpath, color: :green
      rescue => e
        @dev.write " => Create dir  ERROR: "
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
      @dev.write "  * Exists file!     : "
      @dev.writeln dest, color: :yellow
      return true
    end
    begin
      FileUtils.cp(target, dest)
      @dev.write " => Create file      : "
      @dev.writeln dest, color: :green
    rescue => e
      @dev.write " => Create file ERROR: "
      @dev.writeln dest, color: :red
      puts e
    end
  end
end
