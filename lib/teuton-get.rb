# frozen_string_literal: true

require_relative 'teuton-get/application'

require_relative 'teuton-get/reader/inifile_reader'
require_relative 'teuton-get/reader/yaml_reader'
require_relative 'teuton-get/writer/file_writer'
require_relative 'teuton-get/writer/terminal_writer'

require_relative 'teuton-get/repo'
require_relative 'teuton-get/repo_config'
require_relative 'teuton-get/repo_data'
require_relative 'teuton-get/searcher'

class TeutonGet

  def initialize()
    config_filepath = Application.instance.get(:config_filepath)
    @inifile_reader = IniFileReader.new(config_filepath)
  end

  def create_info(testpath)
    repo = Repo.new(progress_writer: TerminalWriter.new)
    repo.create_info(testpath)
  end

  def create_repo(dirpath)
    repo = Repo.new(testinfo_reader: YamlReader.new,
                    repoindex_writer: FileWriter.new,
                    progress_writer: TerminalWriter.new)
    repo.create_repo(dirpath)
  end

  def init()
    config_dirpath = Application.instance.get(:config_dirpath)
    repo_config = RepoConfig.new(config_reader: @inifile_reader,
                                 progress_writer: TerminalWriter.new,
                                 config_dirpath: config_dirpath)
    repo_config.create_config
  end

  def show_repo_list()
    repo_config = RepoConfig.new(config_reader: @inifile_reader,
                                 progress_writer: TerminalWriter.new)
    repo_config.show_list
  end

  def refresh()
    cache_dirpath = Application.instance.get(:cache_dirpath)
    repo_data = RepoData.new(config_reader:   @inifile_reader,
                             progress_writer: TerminalWriter.new,
                             cache_dirpath:   cache_dirpath)
    repo_data.refresh
  end

  def search(filter)
    cache_dirpath = Application.instance.get(:cache_dirpath)
    repo_data = RepoData.new(config_reader:   @inifile_reader,
                             progress_writer: TerminalWriter.new,
                             cache_dirpath:   cache_dirpath)
    searcher = Searcher.new(writer:   TerminalWriter.new,
                            repodata: repo_data,
                            reader:   YamlReader.new)
    result = searcher.get(filter)
    searcher.show(result)
  end

  def download(testname)
    Downloader.get(testname)
  end
end
