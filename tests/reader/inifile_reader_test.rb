#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/teuton-get/reader/inifile_reader'

require 'pry-byebug'
class IniFileReaderTest < Minitest::Test
  def setup
    filepath1 = File.join(File.dirname(__FILE__), 'unkown', 'repos.ini')
    @inifile1 = IniFileReader.new(filepath1)
    filepath2 = File.join(File.dirname(__FILE__), '..', 'files', 'repos.ini')
    @inifile2 = IniFileReader.new(filepath2)
  end

  def test_inifile1_empty
    data = @inifile1.read
    empty = {}
    assert_equal empty, data
  end

  def test_inifile2_repolist
    data = @inifile2.read
    assert_equal 3, data.keys.size
    assert_equal 'main', data.keys[0]
    assert_equal 'local', data.keys[1]
    assert_equal 'foo', data.keys[2]
  end

  def test_inifile2_reponame_main
    data = @inifile2.read
    assert_equal 'Main Teuton repo', data['main']['description']
    assert_equal 'https://raw.githubusercontent.com/teuton-software/teuton-tests/master', data['main']['URL']
    assert_equal true, data['main']['enable']
  end

  def test_inifile2_reponame_local
    data = @inifile2.read
    assert_equal 'Local repo from my PC', data['local']['description']
    assert_equal '/home/david/teuton-tests', data['local']['URL']
    assert_equal true, data['local']['enable']
  end

  def test_inifile2_reponame_foo
    data = @inifile2.read
    assert_equal 'Foo repo', data['foo']['description']
    assert_equal 'https://foo.org', data['foo']['URL']
    assert_equal false, data['foo']['enable']
  end
end
