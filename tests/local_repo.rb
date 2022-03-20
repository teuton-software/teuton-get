#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/teuton-get/local_repo'

class LocalRepoTest < Minitest::Test

  def setup
    @tmpdir = 'var'
  end

  def test_create_info_wrong
    localrepo = LocalRepo.new()

    assert_equal false, localrepo.create_info('tests/files/learn-00-empty')
  end

  def test_create_info_ok
    quietly = ' > /dev/null'
    cmd = "teutonget v #{quietly}"
    ok = system(cmd)

    assert_equal true, ok
    assert_equal 0, $?.exitstatus
  end
end
