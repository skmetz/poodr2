class Schedule
  def scheduled?(schedulable, starting, ending)
    # ...
    puts "This #{schedulable.class} is " +
         "available #{starting} - #{ending}"
    false
  end

  def add(target, starting, ending)
    # ...
  end

  def remove(target, starting, ending)
    # ...
  end
end


module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= Schedule.new
  end

  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # includers may override
  def lead_days
    0
  end
end

class Bicycle
  include Schedulable

  def lead_days
    1
  end
  # ...
end

require 'date'
starting = Date.parse("2019/09/04")
ending   = Date.parse("2019/09/10")

b = Bicycle.new
puts b.schedulable?(starting, ending)
# => This Bicycle is available 2019-09-03 - 2019-09-10
# => true


class Vehicle
  include Schedulable

  def lead_days
    3
  end
  # ...
end

class Mechanic
  include Schedulable

  def lead_days
    4
  end
  # ...
end

v = Vehicle.new
puts v.schedulable?(starting, ending)
# => This Vehicle is available 2019-09-01 - 2019-09-10
# => true


m = Mechanic.new
puts m.schedulable?(starting, ending)
# => This Mechanic is available 2019-08-31 - 2019-09-10
# => true
