require "test/unit"
require "json/pure"

class CommandTest < Test::Unit::TestCase
  def test_teutonget_help
    output = `teutonget help`
    lines = output.split("\n")

    assert(lines.size > 10)
  end

  def test_teutonget_version
    quietly = " > /dev/null"
    cmd = "teutonget v #{quietly}"
    ok = system(cmd)

    assert_equal true, ok
    assert_equal 0, $?.exitstatus
  end

  def test_teutonget_search_ok
    output = `teutonget search local:foo`
    assert_equal 0, $?.exitstatus
    assert_equal true, output.include?("local")
    assert_equal true, output.include?(":foo")
  end

  def test_teutonget_search_ok_no_color
    output = `teutonget search local:foo --no-color`
    assert_equal 0, $?.exitstatus
    assert_equal true, output.include?("(x02) local:foo")
  end

  def test_teutonget_search_ok_format_json
    output = `teutonget search local:foo --no-color --format=json`
    assert_equal 0, $?.exitstatus
    expect = '[{"score":2,"reponame":"local","testname":"foo"}]'
    assert_equal JSON.parse(expect), JSON.parse(output)
  end

  def test_teutonget_search_fail
    output = `teutonget search local:fail`
    assert_equal 1, $?.exitstatus
    assert_equal "", output
  end

  def test_teutonget_search_fail_no_color
    output = `teutonget search local:fail --no-color`
    assert_equal 1, $?.exitstatus
    assert_equal "", output
  end

  def test_teutonget_show_ok_no_color
    output = `teutonget show local:foo --no-color`
    expect = <<~TEXT
      name    : foo
      author  : david
      date    : 2023-02-25
      desc    : Write your description
      tags    : Write your, comma separated, tags
      files   : config.yaml, start.rb, tt-info.yaml
    TEXT
    assert_equal 0, $?.exitstatus
    assert_equal expect, output
  end

  def test_teutonget_show_fail_no_color
    output = `teutonget show local:fail --no-color`
    assert_equal 1, $?.exitstatus
    assert_equal "No results!", output.chomp
  end
end
