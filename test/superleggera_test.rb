require 'test_helper'

class Superleggera::Test < ActiveSupport::TestCase
  setup do
    @middleware = Superleggera::Middleware.new( Object.new )
  end

  test "truth" do
    assert_kind_of Module, Superleggera
  end

  test "can parse classes from an HTML document" do
    classes = @middleware.parse_classes(DOCUMENT)

    assert_equal ["header", "single-quote", "one", "two"], classes
  end

  test "always returns an array" do
    classes = @middleware.parse_classes("<div></div>")

    assert_equal [], classes
  end

  test "reads and writes whitelist to disk" do
    @middleware.write_whitelist(["test"])
    classes = @middleware.load_whitelist
    assert ["test"], classes
  end
end

DOCUMENT = %{
<div class="header"></div>
<div class='single-quote'></div>
<div class="one  two"></div>
}
