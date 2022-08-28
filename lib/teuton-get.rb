require_relative "teuton-get/repo/local_info"
require_relative "teuton-get/repo/local_repo"
require_relative "teuton-get/repo/repo_config"
require_relative "teuton-get/repo/repo_data"
require_relative "teuton-get/searcher"
require_relative "teuton-get/downloader"

module TeutonGet
  def self.create_info(testpath)
    LocalInfo.new.user_create(testpath)
  end

  def self.create_repo(dirpath)
    LocalRepo.new_by_default.create(dirpath)
  end

  def self.init
    RepoConfig.new_by_default.create
    refresh # Auto repo refresh
  end

  def self.refresh
    RepoData.new_by_default.refresh
  end

  def self.show_repo_list
    RepoConfig.new_by_default.show_list
  end

  def self.show_info(test_id)
    repo_data = RepoData.new_by_default
    info = repo_data.get(test_id)
    repo_data.show_testinfo(info)
  end

  def self.search(filter)
    searcher = Searcher.new_by_default
    result = searcher.get(filter)
    searcher.show(result)
  end

  def self.download(test_id)
    Downloader.new.run(test_id)
  end
end
