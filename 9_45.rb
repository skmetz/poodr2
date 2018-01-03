# testing duck types
  # ...
    # ...
# This is a near copy of 5_15.rb
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

class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
      prepare_bicycle(bicycle)}
  end

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

# trip = Trip.new(
#           [Bicycle.new, Bicycle.new, Bicycle.new],
#           [Customer.new, Customer.new],
#           Vehicle.new )
# preparers = [TripCoordinator.new, Driver.new, Mechanic.new]
#
# trip.prepare(preparers)


##########################################################
require "minitest"
require 'minitest/mock'
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new


module PreparerInterfaceTest
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end


##########################################################
class MechanicTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end

  # other tests which rely on @mechanic
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#MechanicTest#**
   **[green]#PASS#** __(0.00s)__  test_implements_the_preparer_interface
 Finished in 0.00014s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
 

##########################################################
class TripCoordinatorTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#TripCoordinatorTest#**
   **[green]#PASS#** __(0.00s)__  test_implements_the_preparer_interface
 Finished in 0.00012s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
 


##########################################################
class DriverTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object =  Driver.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#DriverTest#**
   **[green]#PASS#** __(0.00s)__  test_implements_the_preparer_interface
 Finished in 0.00014s
 1 tests, 1 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
 


##########################################################
class TripTest < Minitest::Test

  def test_requests_trip_preparation
    preparer  = Minitest::Mock.new
    trip      = Trip.new([], [], [])

    preparer.expect(:prepare_trip, nil, [trip])

    trip.prepare([preparer])
    preparer.verify
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#TripTest#**
   **[green]#PASS#** __(0.00s)__  test_requests_trip_preparation
 Finished in 0.00016s
 1 tests, 0 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
