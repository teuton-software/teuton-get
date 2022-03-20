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

  def notest_create_repo
    filepaths = []

    dirpath = @dirpaths[1]
    filepaths << File.join(dirpath, Application::INFOFILENAME)
    @localrepo.create_info(dirpath)

    dirpath = @dirpaths[2]
    filepaths << File.join(dirpath, Application::INFOFILENAME)
    @localrepo.create_info(dirpath)

    filepath = File.join('tests/files', Application::INDEXFILENAME)
    assert_equal false, File.exist?(filepath)

    localrepo.create_repo(dirpath)

    assert_equal true, @localrepo.create_repo(dirpath)
    assert_equal true, File.exist?(filepath)
    #FileUtils.rm(filepath)
  end
end
