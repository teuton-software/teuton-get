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
    LocalInfo.new.user_create(testpath)
  end

  def create_repo(dirpath)
    localrepo = LocalRepo.new(
      repoindex_writer: FileWriter.new,
      progress_writer: TerminalWriter.new
    )
    localrepo.create(dirpath)
  end

  def init
    RepoConfig.new_by_default.create
    refresh # Auto repo refresh
  end

  def refresh
    RepoData.new_by_default.refresh
  end

  def show_repo_list
    RepoConfig.new_by_default.show_list
  end

  def show_info(test_id)
    repo_data = RepoData.new_by_default
    info = repo_data.get(test_id)
    repo_data.show_testinfo(info)
  end

  def search(filter)
    searcher = Searcher.new(
      writer: TerminalWriter.new,
      repodata: RepoData.new_by_default,
      reader: YamlReader.new
    )
    result = searcher.get(filter)
    searcher.show(result)
  end

  def download(test_id)
    Downloader.new.run(test_id)
  end
end
