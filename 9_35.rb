# Add a test to ensure the Wheel plays the Diameterizable role
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

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end

  def diameter
    rim + (tire * 2)
  end
end

# Gear expects a 'Duck' that knows 'diameter'
Gear.new(
        chainring:  52,
        cog:        11,
        wheel:      Wheel.new(26, 1.5))



##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new
    # ...


# Ensure the Wheel is a Diameterizable
class WheelTest < Minitest::Test
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :diameter)
  end

  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29,
                    wheel.diameter,
                    0.01)
  end
end

Minitest.run
 **[rubyclass]#WheelTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_diameter
   **[green]#PASS#** __(0.00s)__  test_implements_the_diameterizable_interface
 Finished in 0.00018s
 2 tests, 2 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
