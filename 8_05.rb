class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size       = size
    @parts      = parts
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :chain, :tire_size

  def initialize(**opts)
    @chain      = opts[:chain]     || default_chain
    @tire_size  = opts[:tire_size] || default_tire_size
    post_initialize(opts)
  end

  def spares
    { chain:     chain,
      tire_size: tire_size}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(**opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    "23"
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock  = opts[:rear_shock]
  end

  def local_spares
    {front_shock: front_shock}
  end

  def default_tire_size
    "2.1"
  end
end


road_bike =
  Bicycle.new(
    size: "L",
    parts: RoadBikeParts.new(tape_color: "red"))

puts road_bike.size
# => L

puts road_bike.spares
# => {:chain=>"11-speed", :tire_size=>"23", :tape_color=>"red"}

mountain_bike =
  Bicycle.new(
    size:  "L",
    parts: MountainBikeParts.new(
            front_shock: 'Manitou',
            rear_shock: "Fox")
    )

puts mountain_bike.size
# => L

puts mountain_bike.spares
# => {:chain=>"11-speed", :tire_size=>"2.1", :front_shock=>"Manitou"}
