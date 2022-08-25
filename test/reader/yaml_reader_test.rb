#!/usr/bin/env ruby

require "test/unit"
require_relative "../../lib/teuton-get/reader/yaml_reader"

class YamlReaderTest < Test::Unit::TestCase
  def setup
    @filepath1 = File.join("unkown", "tt-info.yaml")
    @filepath2 = File.join(File.dirname(__FILE__), "..", "files", "learn-02-config", "tt-info.yaml")
    @reader = YamlReader.new
  end

  def test_read_unkown
    data = @reader.read(@filepath1)
    empty = {}
    assert_equal empty, data
  end

  def test_read_yamlfile_keys
    data = @reader.read(@filepath2)
    assert_equal 8, data.keys.size
    assert_equal "version", data.keys[0]
    assert_equal "type", data.keys[1]
    assert_equal "name", data.keys[2]
    assert_equal "author", data.keys[3]
    assert_equal "date", data.keys[4]
    assert_equal "desc", data.keys[5]
    assert_equal "tags", data.keys[6]
    assert_equal "files", data.keys[7]
  end

  def test_read_yamlfile_values
    data = @reader.read(@filepath2)
    assert_equal "NODATA", data["name"]
    assert_equal "NODATA", data["desc"]
    assert_equal "NODATA", data["author"]
    assert_equal 10, data["date"].to_s.size
    assert_equal 1, data["tags"].size
    assert_equal "NODATA", data["tags"][0]
  end
end
