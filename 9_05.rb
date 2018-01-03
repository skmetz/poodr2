class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end
# ...
end

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring:, cog:, rim:, tire:)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
# ...
end

require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new

##### Wheel is easy to test
class WheelTest < Minitest::Test
  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.diameter,
                    0.01)
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#WheelTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_diameter
 Finished in 0.00014s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#

##### Testing Gear also secretly runs the code in Wheel
##### Wheel is used, everytime you use Gear.
class GearTest < Minitest::Test
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              rim:       26,
              tire:      1.5 )

    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end


Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#GearTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_gear_inches
 Finished in 0.00012s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
