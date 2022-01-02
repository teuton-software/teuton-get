# frozen_string_literal: true

require_relative 'teuton-get/application'

module TeutonGet
  def self.search(filter)
    Searcher.get(filter)
  end

  def self.create_index(dirpath)
    Index.create(dirpath)
  end
end
