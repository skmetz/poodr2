  # ...
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]      || default_chain
    @tire_size  = opts[:tire_size]  || default_tire_size
  end

  def spares
    {tire_size: tire_size,
     chain:     chain}
  end

  def default_chain
    "11-speed"
  end

  def default_tire_size
    raise NotImplementedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super
  end

  def spares
    super.merge(tape_color: tape_color)
  end

  def default_tire_size
    "23"
  end
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


class RecumbentBike < Bicycle
  attr_reader :flag

  def initialize(**opts)
    @flag = opts[:flag]   # forgot to send `super`
  end

  def spares
    super.merge(flag: flag)
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: 'tall and orange')
puts bent.spares
# => {:tire_size=>nil, :chain=>nil, :flag=>"tall and orange"}
# => {:tire_size=>nil,     <- didn't get initialized
# =>  :chain=>nil,
# =>  :flag=>"tall and orange"}
