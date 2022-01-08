#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton-get/application'

class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
  end

  def test_application_env
    dirpath = File.join('/', 'home', 'david')
    assert_equal dirpath, @app.get('HOME')
  end

  def test_param_config_dirpath
    config_dirpath = File.join('/', 'home', 'david', '.teuton')
    assert_equal config_dirpath, @app.get(:config_dirpath)
  end

  def test_param_config_filepath
    config_dirpath = File.join('/', 'home', 'david', '.teuton')
    config_filepath = File.join(config_dirpath, 'repos.ini')
    assert_equal config_filepath, @app.get(:config_filepath)
    assert_equal '/home/david/.teuton/cache', @app.get(:cache_dirpath)
  end

  def test_param_cache_dirpath
    config_dirpath = File.join('/', 'home', 'david', '.teuton')
    cache_dirpath = File.join(config_dirpath, 'cache')
    assert_equal cache_dirpath, @app.get(:cache_dirpath)
  end
end
