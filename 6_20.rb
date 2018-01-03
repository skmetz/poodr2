class Bicycle
  # This class is empty except for initialize.
  # Code has been moved to RoadBike.
  def initialize(**opts)
  end
end

class RoadBike < Bicycle
  # Now a subclass of Bicycle.
  # Contains all code from the old Bicycle class.
  attr_reader :size, :tape_color

  def initialize(**opts)
    @size       = opts[:size]
    @tape_color = opts[:tape_color]
  end

  def spares
    { chain:      '11-speed',
      tire_size:  '23',
      tape_color: tape_color}
  end
  # ...
end

class MountainBike < Bicycle
  # Still a subclass of Bicycle.
  # Code has not changed.
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

puts road_bike.size
# => M

mountain_bike = MountainBike.new(
                  size:        'S',
                  front_shock: 'Manitou',
                  rear_shock:  'Fox')

puts mountain_bike.size
# => undefined method `size' for #<MountainBike:0x00007fd68d947288>
