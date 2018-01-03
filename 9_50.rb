#
  # ...
    # ...
class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def width
    rim + (tire * 2)
  end
end


##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new


##########################################################
class WheelTest < Minitest::Test
  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :width)
  end

  def test_calculates_diameter
    # ...
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.width,
                    0.01)
  end
end

Minitest.run
 **[rubyclass]#WheelTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_diameter
   **[green]#PASS#** __(0.00s)__  test_implements_the_diameterizable_interface
 Finished in 0.00018s
 2 tests, 2 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
