# frozen_string_literal: true

require_relative "teuton-get/downloader"
require_relative "teuton-get/repo/local_info"
require_relative "teuton-get/repo/local_repo"
require_relative "teuton-get/repo/repo_config"
require_relative "teuton-get/repo/repo_data"
require_relative "teuton-get/searcher"
require_relative "teuton-get/writer/format"

module TeutonGet
  def self.create_info(testpath)
    # Create metadata for local user teuton test
    LocalInfo.new.user_created(testpath)
  end

  def self.create_repo(dirpath)
    # Create metadata for local user teuton repository
    LocalRepo.default.create(dirpath)
  end

  def self.download(...)
    # Download teuton test from remote
    Downloader.new.run(...)
  end

  def self.init
    # Create Teuton Repo config file
    RepoConfig.default.create
    refresh # Auto repo refresh
  end

  def self.refresh
    # Refresh Teuton Repo Data
    RepoData.default.refresh
  end

  def self.show_repo_list
    RepoConfig.default.show_list
  end

  def self.show_info(test_id)
    repo_data = RepoData.default
    info = repo_data.get(test_id)
    repo_data.show_testinfo(info) unless info == {}
  end

  def self.search(filter)
    searcher = Searcher.default
    searcher.get(filter)
    searcher.show_results
  end
end
