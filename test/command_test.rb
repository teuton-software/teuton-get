#!/usr/bin/env ruby

require 'test/unit'

class CommandTest < Test::Unit::TestCase

  def test_teuton_get_help
    output = `teutonget help`
    lines = output.split("\n")

    assert_equal 10, lines.size
  end

  def test_teuton_get_version
    quietly = ' > /dev/null'
    cmd = "teutonget v #{quietly}"
    ok = system(cmd)

    assert_equal true, ok
    assert_equal 0, $?.exitstatus
  end
end
