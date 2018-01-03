# Original Bicycle class
class Bicycle
  attr_reader :size, :tape_color

  def initialize(**opts)
    @size       = opts[:size]
    @tape_color = opts[:tape_color]
  end

  # every bike has the same defaults for
  # tire and chain size
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

mountain_bike = MountainBike.new(
                  size:        'S',
                  front_shock: 'Manitou',
                  rear_shock:  'Fox')

puts mountain_bike.size
# => S

puts mountain_bike.spares
# => {:chain=>"11-speed", :tire_size=>"23", :tape_color=>nil, :front_shock=>"Manitou"}
# This should be a copy of out2, dup'd because I want to spread it out and comment on it.
# => {:chain        =>"11-speed",
#     :tire_size    =>"23",         <- wrong!
#     :tape_color   =>nil,          <- not applicable!
#     :front_shock  =>"Manitou"}
