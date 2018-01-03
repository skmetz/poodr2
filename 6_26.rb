class Bicycle
  attr_reader :size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]
    @tire_size  = opts[:tire_size]
  end
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
end

road_bike = RoadBike.new(
              size:       'M',
              tape_color: 'red' )

mountain_bike = MountainBike.new(
                  size:         'S',
                  front_shock:  'Manitou',
                  rear_shock:   'Fox')

puts road_bike.size
# => M

puts mountain_bike.size
# => M
