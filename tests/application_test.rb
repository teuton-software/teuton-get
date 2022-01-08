#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton-get/application'

class ApplicationTest < Minitest::Test
  def setup
    @app = Application.instance
  end

  def test_application_env
    assert_equal '/home/david', @app.get('HOME')
  end

  def test_application_params
    assert_equal '/home/david/.teuton/repos.ini', @app.get(:configpath)
    assert_equal '/home/david/.teuton/cache', @app.get(:cache_dirpath)
  end
end
