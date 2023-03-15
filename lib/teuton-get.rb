# frozen_string_literal: true

require_relative "teuton-get/downloader"
require_relative "teuton-get/repo/local_info"
require_relative "teuton-get/repo/local_repo"
require_relative "teuton-get/repo/repo_config"
require_relative "teuton-get/repo/repo_data"
require_relative "teuton-get/searcher"
require_relative "teuton-get/show_info"

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

  def self.show_repo_list(...)
    RepoConfig.default.show_list(...)
  end

  def self.show_info(...)
    ShowInfo.call(...)
  end

  def self.search(filter, options)
    searcher = Searcher.default
    search = searcher.get(filter)
    exit 1 if search.results.size.zero?

    if options["format"] == "json"
      search.show_json
    else
      search.show_screen
    end
  end
end
