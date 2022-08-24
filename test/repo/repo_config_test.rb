#!/usr/bin/env ruby

require "test/unit"
require_relative "../../lib/teuton-get/repo/repo_config"

class RepoConfigTest < Test::Unit::TestCase
  def test_new_by_default
    r = RepoConfig.new_by_default

    assert_equal Hash, r.data.class
    assert_equal 2, r.data.size
  end
end
