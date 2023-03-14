require "test/unit"
require_relative "../lib/teuton-get/settings"

class SettingsTest < Test::Unit::TestCase
  def setup
    @username = `whoami`.chomp
    @config_path = File.join("/", "home", @username, ".config", "teuton")
  end

  def test_env
    dirpath = File.join("/", "home", @username)
    assert_equal dirpath, Settings.get("HOME")
  end

  def test_param_config_path
    assert_equal @config_path, Settings.get(:config_dirpath)
  end

  def test_param_config_filepath
    config_filepath = File.join(@config_path, "repos.ini")
    assert_equal config_filepath, Settings.get(:config_filepath)
  end

  def test_param_cache_dirpath
    cache_dirpath = File.join(@config_path, "cache")
    assert_equal cache_dirpath, Settings.get(:cache_dirpath)
  end
end
