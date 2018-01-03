  # ...
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]      || default_chain
    @tire_size  = opts[:tire_size]  || default_tire_size

    post_initialize(opts)             # Bicycle both sends
  end

  def spares
    {tire_size: tire_size,
     chain:     chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  def post_initialize(opts)           # and implement this
  end

  # hook for subclasses to override
  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)           # RoadBike can
    @tape_color = opts[:tape_color]   # optionally
  end                                 # override it

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    "23"
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(opts)
    @front_shock = opts[:front_shock]
    @rear_shock  = opts[:rear_shock]
  end

  def spares
    {front_shock: front_shock}
  end

  def default_tire_size
    "2.1"
  end
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
