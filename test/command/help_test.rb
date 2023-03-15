require "test/unit"

class CommandHelpTest < Test::Unit::TestCase
  def test_teutonget_help
    output = `teutonget help`
    lines = output.split("\n")

    assert(lines.size > 10)
  end
end
