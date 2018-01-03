class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]      || default_chain
    @tire_size  = opts[:tire_size]  || default_tire_size
  end

  def default_chain         # <- common default
    "11-speed"
  end
  # ...
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super
  end

  def spares
    { chain:      '11-speed',
      tire_size:  '23',
      tape_color: tape_color}
  end

  def default_tire_size     # <- subclass default
    "23"
  end
  # ...
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock  = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock)
  end

  def default_tire_size     # <- subclass default
    "2.1"
  end
   # ...
end


road_bike = RoadBike.new(
              size:       'M',
              tape_color: 'red' )

puts road_bike.tire_size      # => 23
puts road_bike.chain          # => 11-speed

mountain_bike = MountainBike.new(
                  size:         'S',
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

puts mountain_bike.tire_size  # => 2.1
puts mountain_bike.chain      # => 11-speed

#####  # Bicycle's initialize method sends 'default_tire_size'
#####  # but the class itself does not provide an implementation.
class RecumbentBike < Bicycle
  def default_chain
    '10-speed'
  end
end

bent = RecumbentBike.new(size: "L")
# => undefined local variable or method `default_tire_size' for #<RecumbentBike:0x00007fbe8a126678 @size="L", @chain="10-speed">
