# frozen_string_literal: true

require_relative 'teuton-get/application'
require_relative 'teuton-get/repo'
require_relative 'teuton-get/init'

module TeutonGet
  def self.create_repo(dirpath)
    Repo.create(dirpath)
  end

  def self.init()
    Init.create
  end

  def self.show_repo_list()
    Repo.show_list
  end

  def self.search(filter)
    Searcher.get(filter)
  end

  def self.download(testname)
    Downloader.get(testname)
  end
end
