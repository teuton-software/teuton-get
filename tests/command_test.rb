#!/usr/bin/env ruby

require 'minitest/autorun'

# MiniTest Rubocop
class CommandTest < Minitest::Test

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
