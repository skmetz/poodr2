class Trip
  attr_reader :bicycles, :customers, :vehicle

  def initialize(bicycles, customers, vehicles)
    @bicycles   = bicycles
    @customers  = customers
    @vehicle   = vehicle
  end

  # this 'mechanic' argument could be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end

  # ...
end

# if you happen to pass an instance of *this* class,
# it works
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each {|bicycle| prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    #...
  end
end

class Bicycle
end

class Customer
end

class Vehicle
end


Trip.new(
  [Bicycle.new, Bicycle.new, Bicycle.new],
  [Customer.new, Customer.new],
  Vehicle.new
  ).prepare(Mechanic.new)
