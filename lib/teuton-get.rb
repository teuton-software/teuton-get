require_relative "teuton-get/application"

require_relative "teuton-get/reader/inifile_reader"
require_relative "teuton-get/reader/yaml_reader"
require_relative "teuton-get/writer/file_writer"
require_relative "teuton-get/writer/terminal_writer"

require_relative "teuton-get/repo/local_info"
require_relative "teuton-get/repo/local_repo"
require_relative "teuton-get/repo/repo_config"
require_relative "teuton-get/repo/repo_data"
require_relative "teuton-get/searcher"
require_relative "teuton-get/downloader"

class TeutonGet
  def initialize
    config_filepath = Application.instance.get(:config_filepath)
    @inifile_reader = IniFileReader.new(config_filepath)
  end

  def create_info(testpath)
    LocalInfo.new.create(testpath)
  end

  def create_repo(dirpath)
    localrepo = LocalRepo.new(
      repoindex_writer: FileWriter.new,
      progress_writer: TerminalWriter.new
    )
    localrepo.create(dirpath)
  end

  def init
    config_dirpath = Application.instance.get(:config_dirpath)
    repo_config = RepoConfig.new(
      config_reader: @inifile_reader,
      progress_writer: TerminalWriter.new,
      config_dirpath: config_dirpath
    )
    repo_config.create
    refresh # Refresh repo-cache just after config file creation
  end

  def refresh
    cache_dirpath = Application.instance.get(:cache_dirpath)
    repo_data = RepoData.new(
      config_reader: @inifile_reader,
      progress_writer: TerminalWriter.new,
      cache_dirpath: cache_dirpath
    )
    repo_data.refresh
  end

  def show_repo_list
    repo_config = RepoConfig.new_by_default
    repo_config.show_list
  end

  def search(filter)
    cache_dirpath = Application.instance.get(:cache_dirpath)
    repo_data = RepoData.new(
      config_reader: @inifile_reader,
      progress_writer: TerminalWriter.new,
      cache_dirpath: cache_dirpath
    )
    searcher = Searcher.new(
      writer: TerminalWriter.new,
      repodata: repo_data,
      reader: YamlReader.new
    )
    result = searcher.get(filter)
    searcher.show(result)
  end

  def download(test_id)
    Downloader.new.run(test_id)
  end
end
