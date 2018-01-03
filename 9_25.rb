# Injecting a Test Double
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
        wheel:      Wheel.new(26, 1.5)).gear_inches rescue "died"



##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new


##### Remove the Gear test's dependency on the Wheel class by
##### injecting something that HONORS the diameterable role,
##### instead of BEING the Wheel class.
#####
# Create a player of the 'Diameterizable' role
class DiameterDouble
  def diameter
    10
  end
end

class GearTest < Minitest::Test
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
 **[rubyclass]#GearTest#**
   **[green]#PASS#** __(0.00s)__  test_calculates_gear_inches
 Finished in 0.00015s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
