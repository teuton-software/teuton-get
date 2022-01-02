# frozen_string_literal: true

require_relative 'teuton-get/application'
require_relative 'teuton-get/repo'

module TeutonGet
  def self.search(filter)
    Searcher.get(filter)
  end

  def self.create_repo(dirpath)
    Repo.create(dirpath)
  end
end
