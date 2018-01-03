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


class RecumbentBike < Bicycle
  def default_chain
    '10-speed'
  end
end

bent = RecumbentBike.new(size: "L")
# => NotImplementedError
