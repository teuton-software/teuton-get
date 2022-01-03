# frozen_string_literal: true

require_relative 'teuton-get/application'
require_relative 'teuton-get/repo'
require_relative 'teuton-get/reader/inifile_reader'
require_relative 'teuton-get/reader/yaml_reader'
require_relative 'teuton-get/writer/terminal_writer'
require_relative 'teuton-get/init'

class TeutonGet

  def initialize()
    home = Application.instance.get('HOME')
    filename = Application::CONFIGFILE
    filepath = "#{home}/.teuton/#{filename}"

    @repo = Repo.new(config_reader: IniFileReader.new(filepath),
                     testinfo_reader: YamlReader.new,
                     writer: TerminalWriter.new)
  end

  def create_repo(dirpath)
    @repo.create(dirpath)
  end

  def init()
    home     = Application.instance.get('HOME')
    dirpath  = File.join(home, '.teuton')
    filepath = File.join(home, '.teuton', Application::CONFIGFILE)
    init     = Init.new(dirpath: dirpath,
                        filepath: filepath,
                        writer: TerminalWriter.new)
    init.create
  end

  def show_repo_list()
    @repo.show_list
  end

  def search(filter)
    Searcher.get(filter)
  end

  def download(testname)
    Downloader.get(testname)
  end
end
