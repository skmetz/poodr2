# Changing the implementor but not the sender (the API but not the caller)
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  # ...
  def gear_inches
    ratio * wheel.diameter  # <--- obsolete
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

  def width   # <---- used to be 'diameter'
    rim + (tire * 2)
  end
  # ...
end

# Gear expects a 'Duck' that knows 'diameter'
puts Gear.new(
        chainring:  52,
        cog:        11,
        wheel:      Wheel.new(26, 1.5)).gear_inches rescue "Gear.new died"


##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new


##### The API of Wheel has changed but Gear didn't get updated
class GearTest < Minitest::Test
  def test_calculates_gear_inches
    gear =  Gear.new(
              chainring: 52,
              cog:       11,
              wheel:     Wheel.new(26, 1.5))

    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end

Minitest.run
 **[rubyclass]#GearTest#**
   **[red]#ERROR#** __(0.00s)__  test_calculates_gear_inches
 NoMethodError:         NoMethodError: undefined method `diameter' for +#+<Wheel:0x00007ff74010f448 @rim=26, @tire=1.5>

 Finished in 0.00064s
 1 tests, 0 assertions, [red]#0 failures, 1 errors#, [yellow]#0 skips#
