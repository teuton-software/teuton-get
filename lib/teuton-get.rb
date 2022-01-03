# frozen_string_literal: true

require_relative 'teuton-get/application'
require_relative 'teuton-get/repo'
require_relative 'teuton-get/reader/inifile_reader'
require_relative 'teuton-get/reader/yaml_reader'
require_relative 'teuton-get/init'

class TeutonGet

  def initialize()
    @repo = Repo.new(config_reader: IniFileReader.new,
                     testinfo_reader: YamlReader.new)
  end

  def create_repo(dirpath)
    @repo.create(dirpath)
  end

  def init()
    Init.create
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
