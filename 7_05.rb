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


class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  # Inject the Schedule and provide a default
  def initialize(**opts)
    @schedule = opts[:schedule] || Schedule.new
    # ...
  end

  # Return true if this bicycle is available
  # during this (now Bicycle specific) interval.
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  # Return the schedule's answer
  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # Return the number of lead_days before a bicycle
  # can be scheduled.
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
