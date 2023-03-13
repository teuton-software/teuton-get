require "test/unit"
require_relative "../../lib/teuton-get/repo/repo_config"

class RepoConfigTest < Test::Unit::TestCase
  def test_default
    r = RepoConfig.default

    assert_equal Hash, r.data.class
    assert_equal 3, r.data.size
  end
end
