#!/usr/bin/env ruby

require "test/unit"

require_relative "../../lib/teuton-get/repo/local_info"
require_relative "../../lib/teuton-get/reader/yaml_reader"
require_relative "../../lib/teuton-get/writer/file_writer"
require_relative "../../lib/teuton-get/writer/null_writer"

class LocalInfoTest < Test::Unit::TestCase
  def setup
    @tmpdir = "var"
    @localinfo = LocalInfo.new(NullWriter.new)
    @dirpaths = [
      "test/files/learn-00-empty",
      "test/files/learn-01-target",
      "test/files/learn-02-config"
    ]
  end

  def test_create_info_wrong
    dirpath = @dirpaths[0]
    filepath = File.join(dirpath, Application::INFOFILENAME)

    assert_equal true, File.exist?(dirpath)
    assert_equal false, File.exist?(filepath)
    assert_equal false, @localinfo.create(dirpath)
    assert_equal false, File.exist?(filepath)
  end

  def test_create_info_ok
    dirpath = @dirpaths[1]
    filepath = File.join(dirpath, Application::INFOFILENAME)

    assert_equal true, File.exist?(dirpath)
    assert_equal false, File.exist?(filepath)
    assert_equal true, @localinfo.create(dirpath)
    assert_equal true, File.exist?(filepath)
    FileUtils.rm(filepath)
  end

  def test_read_no_exist_info
    dirpath = @dirpaths[1]
    filepath = File.join(dirpath, Application::INFOFILENAME)
    data = @localinfo.read(filepath)
    assert_equal({}, data)
  end

  def test_read_info_file
    dirpath = @dirpaths[2]
    filepath = File.join(dirpath, Application::INFOFILENAME)
    data = @localinfo.read(filepath)
    assert_equal(7, data.size)
  end
end
