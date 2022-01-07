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
    home = Application.instance.get('HOME')
    filename = Application::CONFIGFILE
    configpath = "#{home}/.teuton/#{filename}"
    @inifile_reader = IniFileReader.new(configpath)


    cache_dirpath = "#{home}/.teuton/cache"
    @repo_data = RepoData.new(config_reader: @inifile_reader,
                              progress_writer: TerminalWriter.new,
                              cache_dirpath: cache_dirpath)
  end

  def create_repo(dirpath)
    @repo = Repo.new(testinfo_reader: YamlReader.new,
                     repoindex_writer: FileWriter.new,
                     progress_writer: TerminalWriter.new)
    @repo.create_repo(dirpath)
  end

  def init()
    home     = Application.instance.get('HOME')
    dirpath  = File.join(home, '.teuton')
    @repo_config = RepoConfig.new(config_reader: @inifile_reader,
                                  progress_writer: TerminalWriter.new,
                                  dirpath: dirpath)
    @repo_config.create_config
  end

  def show_repo_list()
    @repo_config = RepoConfig.new(config_reader: @inifile_reader,
                                  progress_writer: TerminalWriter.new)
    @repo_config.show_list
  end

  def refresh()
    @repo_data.refresh
  end

  def search(filter)
    @searcher = Searcher.new(repo: @repo_data,
                             writer: TerminalWriter.new,
                             reader: YamlReader.new)
    result = @searcher.get(filter)
    @searcher.show(result)
  end

  def download(testname)
    Downloader.get(testname)
  end
end
