require "test/unit"

class CommandVersionTest < Test::Unit::TestCase
  def test_teutonget_version
    quietly = " > /dev/null"
    cmd = "teutonget v #{quietly}"
    ok = system(cmd)

    assert_equal true, ok
    assert_equal 0, $?.exitstatus
  end
end
