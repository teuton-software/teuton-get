require "test/unit"
require "json/pure"

class CommandSearchTest < Test::Unit::TestCase
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
end
