# Trip preparation becomes easier
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def initialize(bicycles, customers, vehicle)
    @bicycles   = bicycles
    @customers  = customers
    @vehicle    = vehicle
  end

  def prepare(preparers)
    preparers.each {|preparer|
      preparer.prepare_trip(self)}
  end
  # ...
end

# when every preparer is a Duck
# that responds to 'prepare_trip'
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
      prepare_bicycle(bicycle)}
  end
  # ...
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycle| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    #...
    puts "Mechanic prepare_bicycle #{bicycle}"
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  # ...
  def buy_food(customers)
    # ...
    puts "TripCoordinator buy_food"
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
  def gas_up(vehicle)
    #...
    puts "Driver gas_up"
  end

  def fill_water_tank(vehicle)
    #...
    puts "Driver fill_water_tank"
  end
end

class Bicycle
end

class Customer
end

class Vehicle
end

trip = Trip.new(
          [Bicycle.new, Bicycle.new, Bicycle.new],
          [Customer.new, Customer.new],
          Vehicle.new )
preparers = [TripCoordinator.new, Driver.new, Mechanic.new]

trip.prepare(preparers)
