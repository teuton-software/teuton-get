#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton-get/application'

class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
    @config_path = File.join('/', 'home', 'david', '.config', 'teuton')
  end

  def test_application_env
    dirpath = File.join('/', 'home', 'david')
    assert_equal dirpath, @app.get('HOME')
  end

  def test_param_config_path
    assert_equal @config_path, @app.get(:config_dirpath)
  end

  def test_param_config_filepath
    config_filepath = File.join(@config_path, 'repos.ini')
    assert_equal config_filepath, @app.get(:config_filepath)
  end

  def test_param_cache_dirpath
    cache_dirpath = File.join(@config_path, 'cache')
    assert_equal cache_dirpath, @app.get(:cache_dirpath)
  end
end
