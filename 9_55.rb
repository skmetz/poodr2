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

class DiameterDouble
  def diameter
    10
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end


##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new


module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
   assert_respond_to(@object, :width)
  end
end


##########################################################
class WheelTest < Minitest::Test
  include DiameterizableInterfaceTest

  def setup
    @wheel = @object = Wheel.new(26, 1.5)
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
Minitest::Runnable.reset
 **[rubyclass]#WheelTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_diameter
   **[green]#PASS#** __(0.00s)__  test_implements_the_diameterizable_interface
 Finished in 0.00018s
 2 tests, 2 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


##########################################################
# Prove the test double honors the interface this
#   test expects.
class DiameterDoubleTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest

  def setup
    @object = DiameterDouble.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#DiameterDoubleTest#**
   **[red]#FAIL#** __(0.00s)__  test_implements_the_diameterizable_interface
 Minitest::Assertion:         Expected +#+<DiameterDouble:0x007fefc2070d00> (DiameterDouble) to respond to ++#++width.
         9_55.rb:50:in `test_implements_the_diameterizable_interface'
         # . . .
 
 Finished in 0.00022s
 1 tests, 1 assertions, [red]#1 failures, 0 errors#, [yellow]#0 skips#

##########################################################
class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              wheel:     DiameterDouble.new)

    assert_in_delta(47.27,
                    gear.gear_inches,
                    0.01)
  end
end

Minitest.run
Minitest::Runnable.reset
 
 **[rubyclass]#GearTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_gear_inches
 Finished in 0.00010s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
