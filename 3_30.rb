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

############################
# using fixed args
############################
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
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

puts Gear.new(
      52,
      11,
      Wheel.new(26, 1.5)).gear_inches
# => 137.0909090909091

############################
# using hash
############################
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end
  # ...
  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(
      :chainring => 52,
      :cog       => 11,
      :wheel     => Wheel.new(26, 1.5)).gear_inches
# => 137.0909090909091

puts Gear.new(
      :wheel     => Wheel.new(26, 1.5),
      :chainring => 52,
      :cog       => 11).gear_inches
# => 137.0909090909091

############################
# using keyword args
############################
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:)
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

puts Gear.new(
      :cog       => 11,
      :chainring => 52,
      :wheel     => Wheel.new(26, 1.5)).gear_inches
# => 137.0909090909091

puts Gear.new(
      wheel:     Wheel.new(26, 1.5),
      chainring: 52,
      cog:       11).gear_inches
# => 137.0909090909091
