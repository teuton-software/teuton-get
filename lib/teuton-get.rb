# frozen_string_literal: true

require "json/pure"
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

  def self.show_info(test_id, options)
    repo_data = RepoData.default
    testinfo = repo_data.get_info(test_id)

    if testinfo == {}
      results = Searcher.default.get(test_id).results
      if results.size == 1
        test_id = results[0][:id]
      else
        puts "(#{results.size} results!)"
        results.each { |i| puts "* #{i[:id]}" }
        exit 1
      end
    end

    testinfo = repo_data.get_info(test_id)
    exit 1 if testinfo == {}

    if options["format"] == "json"
      puts testinfo.to_json
    else
      repo_data.show_testinfo(testinfo)
    end
  end

  def self.search(filter, options)
    searcher = Searcher.default
    results = searcher.get(filter)
    if options["format"] == "json"
      results.show_json
    else
      results.show_screen
    end
  end
end
