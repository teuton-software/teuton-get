#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton-get/repo/local_repo'
require_relative '../lib/teuton-get/reader/yaml_reader'
require_relative '../lib/teuton-get/writer/file_writer'
require_relative '../lib/teuton-get/writer/null_writer'

class LocalRepoTest < Minitest::Test

  def setup
    @tmpdir = 'var'
    @localrepo = LocalRepo.new(testinfo_reader: YamlReader.new,
                               repoindex_writer: FileWriter.new,
                               progress_writer: NullWriter.new)
    @dirpaths = ['tests/files/learn-00-empty',
                 'tests/files/learn-01-target',
                 'tests/files/learn-02-config']
  end

  def test_create_info_wrong
    dirpath = @dirpaths[0]
    filepath = File.join(dirpath, Application::INFOFILENAME)

    assert_equal true, File.exist?(dirpath)
    assert_equal false, File.exist?(filepath)
    assert_equal false, @localrepo.create_info(dirpath)
    assert_equal false, File.exist?(filepath)
  end

  def test_create_info_ok
    dirpath = @dirpaths[1]
    filepath = File.join(dirpath, Application::INFOFILENAME)

    assert_equal true, File.exist?(dirpath)
    assert_equal false, File.exist?(filepath)
    assert_equal true, @localrepo.create_info(dirpath)
    assert_equal true, File.exist?(filepath)
    FileUtils.rm(filepath)
  end

  def test_create_repo
    tempfiles = []

    dirpath = @dirpaths[1]
    @localrepo.create_info(dirpath)
    tempfiles << File.join(dirpath, Application::INFOFILENAME)

    dirpath = @dirpaths[2]
    @localrepo.create_info(dirpath)

    indexfilepath = File.join('tests/files', Application::INDEXFILENAME)
    assert_equal false, File.exist?(indexfilepath)

    assert_equal true, @localrepo.create_repo('tests/files')
    assert_equal true, File.exist?(indexfilepath)
    tempfiles << indexfilepath

    tempfiles.each { |filepath| FileUtils.rm(filepath) }
  end
end
