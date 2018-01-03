class Mechanic
  # def prepare_trip(trip)
  #   trip.bicycles.each {|bicycle|
  #     prepare_bicycle(bicycle)}
  # end
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
  # def prepare_trip(trip)
  #   buy_food(trip.customers)
  # end
  # ...
  def buy_food(customers)
    # ...
    puts "TripCoordinator buy_food"
  end
end

class Driver
  # def prepare_trip(trip)
  #   vehicle = trip.vehicle
  #   gas_up(vehicle)
  #   fill_water_tank(vehicle)
  # end
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



###############################
# Initial example
###############################
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def initialize(bicycles, customers, vehicle)
    @bicycles   = bicycles
    @customers  = customers
    @vehicle    = vehicle
  end

  def prepare(preparers)
    preparers.each {|preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
  # ...
end

puts "\nInitial example:"
trip = Trip.new(
          [Bicycle.new, Bicycle.new, Bicycle.new],
          [Customer.new, Customer.new],
          Vehicle.new )
preparers = [TripCoordinator.new, Driver.new, Mechanic.new]

trip.prepare(preparers)



###############################
# kind_of? example
###############################
class Trip
  def prepare(preparers)
    preparers.each {|preparer|
      if preparer.kind_of?(Mechanic)
        preparer.prepare_bicycles(bicycles)
      elsif preparer.kind_of?(TripCoordinator)
        preparer.buy_food(customers)
      elsif preparer.kind_of?(Driver)
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

puts "\nkind_of? example:"
trip = Trip.new(
          [Bicycle.new, Bicycle.new, Bicycle.new],
          [Customer.new, Customer.new],
          Vehicle.new )
preparers = [TripCoordinator.new, Driver.new, Mechanic.new]

trip.prepare(preparers)


###############################
# respond_to? example
###############################
class Trip
  def prepare(preparers)
    preparers.each {|preparer|
      if preparer.respond_to?(:prepare_bicycles)
        preparer.prepare_bicycles(bicycles)
      elsif preparer.respond_to?(:buy_food)
        preparer.buy_food(customers)
      elsif preparer.respond_to?(:gas_up)
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    }
  end
end

puts "\nrespond_to? example:"
trip = Trip.new(
          [Bicycle.new, Bicycle.new, Bicycle.new],
          [Customer.new, Customer.new],
          Vehicle.new )
preparers = [TripCoordinator.new, Driver.new, Mechanic.new]

trip.prepare(preparers)
