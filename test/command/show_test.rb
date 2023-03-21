require "test/unit"
require "json/pure"

class CommandShowTest < Test::Unit::TestCase
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

  def test_teutonget_show_ok_format_json
    output = `teutonget show local:foo --format=json`
    expect = '{"version":1,"type":"teutontest","name":"foo","author":"david","date":"2023-02-25","desc":"Write your description","tags":["Write your","comma separated","tags"],"files":["config.yaml","start.rb","tt-info.yaml"]}'
    assert_equal 0, $?.exitstatus
    assert_equal JSON.parse(expect), JSON.parse(output)
  end

  def test_teutonget_show_fail_no_color
    output = `teutonget show local:fail --no-color`
    assert_equal 1, $?.exitstatus
    assert_equal "No results!", output.chomp
  end

  def test_teutonget_show_fail_format_json
    output = `teutonget show local:fail --format=json`
    assert_equal 1, $?.exitstatus
    assert_equal "No results!", output.chomp
  end
end
