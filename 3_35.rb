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

###########################
# KEYWORD ARGS
#    keyword arg with simple defaults
###########################
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring: 40, cog: 18, wheel:)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  # ...
  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring
# => 40


###########################
# KEYWORD ARGS
#    keyword arg with defaults
###########################
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring: default_chainring, cog: 18, wheel:)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def default_chainring
    (100/2) - 10        # silly code, useful example
  end
  # ...
  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring
# => 40

puts Gear.new(chainring: 52, wheel: Wheel.new(26, 1.5)).chainring
# => 52
