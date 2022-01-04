# frozen_string_literal: true

require_relative 'teuton-get/application'

require_relative 'teuton-get/reader/inifile_reader'
require_relative 'teuton-get/reader/yaml_reader'
require_relative 'teuton-get/writer/file_writer'
require_relative 'teuton-get/writer/terminal_writer'

require_relative 'teuton-get/init'
require_relative 'teuton-get/repo'
require_relative 'teuton-get/searcher'

class TeutonGet

  def initialize()
    home = Application.instance.get('HOME')
    filename = Application::CONFIGFILE
    filepath = "#{home}/.teuton/#{filename}"

    @repo = Repo.new(config_reader: IniFileReader.new(filepath),
                     testinfo_reader: YamlReader.new,
                     repoindex_writer: FileWriter.new,
                     progress_writer: TerminalWriter.new)

    cache_dirpath = "#{home}/.teuton/cache"
    @searcher = Searcher.new(cache_dirpath: cache_dirpath,
                             repo: @repo,
                             writer: TerminalWriter.new,
                             reader: YamlReader.new)
  end

  def create_repo(dirpath)
    @repo.create(dirpath)
  end

  def init()
    home     = Application.instance.get('HOME')
    dirpath  = File.join(home, '.teuton')
    filepath = File.join(dirpath, Application::CONFIGFILE)
    init     = Init.new(dirpath: dirpath,
                        filepath: filepath,
                        writer: TerminalWriter.new)
    init.create
  end

  def show_repo_list()
    @repo.show_list
  end

  def refresh()
    @searcher.refresh
  end

  def search(filter)
    result = @searcher.get(filter)
    @searcher.show(result)
  end

  def download(testname)
    Downloader.get(testname)
  end
end
