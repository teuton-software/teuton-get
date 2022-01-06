#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/teuton-get/searcher/result'

class ResultTest < Minitest::Test
  def setup
  end

  def test_result_hash
    result = Result.new({})

    assert_equal 0, result.score
    assert_equal '???', result.reponame
    assert_equal '???', result.testname
    assert_equal '???@???', result.id
  end

  def test_result
    result = Result.new(score: 16,
                        reponame: 'main',
                        testname: 'sysadmin/debian')

    assert_equal 16, result.score
    assert_equal 'main', result.reponame
    assert_equal 'sysadmin/debian', result.testname
    assert_equal 'main@sysadmin/debian', result.id
  end

end
