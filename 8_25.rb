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

require 'forwardable'
class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select {|part| part.needs_spare}
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(name:, description:, needs_spare: true)
    @name         = name
    @description  = description
    @needs_spare  = needs_spare
  end
end

################
module PartsFactory
 def self.build(config:,
                part_class: Part,
                parts_class: Parts)

   parts_class.new(
     config.collect {|part_config|
       part_class.new(
         name:         part_config[0],
         description:  part_config[1],
         needs_spare:  part_config.fetch(2, true))})
 end
end

################
road_config =
  [['chain',        '11-speed'],
   ['tire_size',    '23'],
   ['tape_color',   'red']]

mountain_config =
  [['chain',        '11-speed'],
   ['tire_size',    '2.1'],
   ['front_shock',  'Manitou'],
   ['rear_shock',   'Fox', false]]


puts PartsFactory.build(config: road_config).inspect
# => #<Parts:0x00007f83f0046bd8 @parts=[#<Part:0x00007f83f0046d40 @name="chain", @description="11-speed", @needs_spare=true>, #<Part:0x00007f83f0046cc8 @name="tire_size", @description="23", @needs_spare=true>, #<Part:0x00007f83f0046c28 @name="tape_color", @description="red", @needs_spare=true>]>

# to get it nicely formated, check if you regenerate
# => #<Parts:0x007fb903932718 @parts=[
#       #<Part:0x007fb9039328a8
#         @name="chain",
#         @description="11-speed",
#         @needs_spare=true>,
#       #<Part:0x007fb903932808
#         @name="tire_size",
#         etc...

puts PartsFactory.build(config: mountain_config).inspect
# => #<Parts:0x00007f83f00464d0 @parts=[#<Part:0x00007f83f00466d8 @name="chain", @description="11-speed", @needs_spare=true>, #<Part:0x00007f83f0046638 @name="tire_size", @description="2.1", @needs_spare=true>, #<Part:0x00007f83f0046598 @name="front_shock", @description="Manitou", @needs_spare=true>, #<Part:0x00007f83f0046520 @name="rear_shock", @description="Fox", @needs_spare=false>]>

# to get it nicely formated, check if you regenerate
# => #<Parts:0x007fb903931f98 @parts=[
#       #<Part:0x007fb9039321c8
#         @name="chain",
#         @description="11-speed",
#         @needs_spare=true>,
#       #<Part:0x007fb903932150
#         @name="tire_size",
#         etc...
