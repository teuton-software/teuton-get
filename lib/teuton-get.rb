# frozen_string_literal: true

require_relative 'teuton-get/application'
require_relative 'teuton-get/repo'

module TeutonGet
  def self.create_repo(dirpath)
    Repo.create(dirpath)
  end

  def self.search(filter)
    Searcher.get(filter)
  end

  def self.download(testname)
    Downloader.get(testname)
  end
end
