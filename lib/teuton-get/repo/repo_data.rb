# frozen_string_literal: true

require "yaml"
require_relative "../settings"
require_relative "../reader/url_reader"
require_relative "../reader/inifile_reader"
require_relative "../reader/yaml_reader"

class RepoData
  attr_reader :data

  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
    @dev = args[:progress_writer]
    @cache_dirpath = args[:cache_dirpath]
  end

  def self.default
    config_filepath = Settings.get(:config_filepath)
    RepoData.new(
      config_reader: IniFileReader.new(config_filepath),
      progress_writer: TerminalWriter.new,
      cache_dirpath: Settings.get(:cache_dirpath)
    )
  end

  def refresh
    @database = {}
    dirpath = @cache_dirpath
    FileUtils.rm_r(dirpath) if Dir.exist? dirpath

    @dev.writeln "\n==> Refreshing active repos"
    @data.keys.sort.each do |key|
      refresh_repo key
    end
    save_database
  end

  def get_info(test_id)
    reponame, id = test_id.split(Settings::SEPARATOR)
    database = YamlReader.new.read(database_filename)
    return {} if database[reponame].nil?
    database[reponame][id] || {}
  end

  def show_testinfo(item)
    return unless item

    ["name", "author", "date", "desc"].each do |key|
      @dev.write "#{key.ljust(7)} : ", color: :white
      @dev.writeln item[key].to_s
    end
    ["tags", "files"].each do |key|
      next if item[key].nil?
      @dev.write "#{key.ljust(7)} : ", color: :white
      @dev.writeln item[key].join(", ")
    end
  end

  def database_filename
    # REVISE: Used by teutonget search... replace by #get()
    unless Dir.exist? @cache_dirpath
      puts "    [WARN] Create Teuton config files!"
      puts "    Usage: teutonget init"
      exit 1
    end

    File.join(@cache_dirpath, "database.yaml")
  end

  private

  def refresh_repo(reponame)
    unless enabled? reponame
      @dev.writeln "    \u{2716} Skiping repo #{reponame}", color: :yellow
      return false
    end
    dirpath = File.join(@cache_dirpath)
    ok1 = create_dir(dirpath)
    ok2 = get_database(reponame)

    @dev.writeln "    \u{2714} Repo #{reponame} (#{ok2.size} tests)"

    true && ok1 && ok2
  end

  def enabled?(reponame)
    @data[reponame]["enable"] == true
  end

  def create_dir(dirpath)
    unless Dir.exist? dirpath
      begin
        FileUtils.mkdir_p(dirpath)
        return true
      rescue => e
        @dev.write "* Create dir  ERROR => "
        @dev.writeln dirpath, color: :red
        puts e
        return false
      end
    end
    false
  end

  def get_database(reponame)
    data = @data[reponame]

    @database[reponame] = if data["URL"].start_with? "http"
      get_remote_database(data["URL"])
    else
      get_local_database(data["URL"])
    end
  end

  def get_local_database(dirpath)
    filepath = File.join(dirpath, Settings::INDEXFILENAME)
    # @reader.read(filepath) # FIXME
    YAML.safe_load(
      File.read(filepath),
      permitted_classes: [Array, Date, Hash, Symbol]
    )
  end

  def get_remote_database(url_repo)
    url_file = "#{url_repo}/#{Settings::INDEXFILENAME}"
    content_page = URLReader.new(url_file).read
    YAML.safe_load(
      content_page,
      permitted_classes: [Array, Date, Hash, Symbol]
    )
  end

  def save_database
    File.write(database_filename, @database.to_yaml)
  end
end
