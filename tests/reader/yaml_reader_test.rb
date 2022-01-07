#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/teuton-get/reader/yaml_reader'

class YamlReaderTest < Minitest::Test
  def setup
    @filepath1 = File.join('unkown', 'tt-info.yaml')
    @filepath2 = File.join(File.dirname(__FILE__), '..', 'files', 'tt-info.yaml')
    @reader = YamlReader.new
  end

  def test_read_unkown
    data = @reader.read(@filepath1)
    empty = {}
    assert_equal empty, data
  end

  def test_read_yamlfile_keys
    data = @reader.read(@filepath2)
    assert_equal 5, data.keys.size
    assert_equal 'name', data.keys[0]
    assert_equal 'description', data.keys[1]
    assert_equal 'author', data.keys[2]
    assert_equal 'date', data.keys[3]
    assert_equal 'tags', data.keys[4]
  end

  def test_read_yamlfile_values
    data = @reader.read(@filepath2)
    assert_equal 'OpenSUSE conf', data['name']
    assert_equal 'OpenSUSE basic configuration', data['description']
    assert_equal 'dvarrui', data['author']
    assert_equal '2020-09-06', data['date'].to_s
    assert_equal 6, data['tags'].size
    assert_equal 'OpenSUSE', data['tags'][0]
    assert_equal 'basic', data['tags'][1]
    assert_equal 'hostname', data['tags'][2]
    assert_equal 'ip', data['tags'][3]
    assert_equal 'gateway', data['tags'][4]
    assert_equal 'configuration', data['tags'][5]
  end

end
