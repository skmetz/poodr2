  # ...
    # ...
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size       = opts[:size]
    @chain      = opts[:chain]      || default_chain
    @tire_size  = opts[:tire_size]  || default_tire_size
    post_initialize(opts)
  end

  def spares
    {tire_size: tire_size,
     chain:     chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts)
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    "23"
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(opts)
    @front_shock = opts[:front_shock]
    @rear_shock  = opts[:rear_shock]
  end

  def spares
    {front_shock: front_shock}
  end

  def default_tire_size
    "2.1"
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(opts)
    @flag = opts[:flag]
  end

  def local_spares
    {flag: flag}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    '28'
  end
end


##########################################################
require "minitest"
require "minitest/reporters"
require "minitest/asciidoc_plugin"

Minitest::Reporters.use! Minitest::Reporters::Asciidoc.new

#################################
module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_responds_to_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_tire_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end


class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#BicycleTest#**
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00029s
 6 tests, 6 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = RoadBike.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#RoadBikeTest#**
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00021s
 6 tests, 6 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


#################################
module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

# for minitest to get a new lease on testing life
Object.send(:remove_const, :RoadBikeTest)

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#RoadBikeTest#**
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_local_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_post_initialize
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00024s
 8 tests, 8 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


class MountainBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#MountainBikeTest#**
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_local_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_post_initialize
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00024s
 8 tests, 8 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#



#################################
Object.send(:remove_const, :BicycleTest)

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#BicycleTest#**
   **[green]#PASS#** __(0.00s)__  test_forces_subclasses_to_implement_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00032s
 7 tests, 7 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


#################################
Object.send(:remove_const, :RoadBikeTest)

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end

  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#RoadBikeTest#**
   **[green]#PASS#** __(0.00s)__  test_puts_tape_color_in_local_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_local_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_post_initialize
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00028s
 9 tests, 9 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


#################################
Object.send(:remove_const, :BicycleTest)

class BikeDouble < Bicycle
  def default_tire_size
    0
  end

  def local_spares
    {saddle: 'painful'}
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
    @double = BikeDouble.new
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {
      @bike.default_tire_size}
  end

  def test_includes_local_spares_in_spares
    assert_equal @double.spares,
                 { tire_size: 0,
                   chain:     '11-speed',
                   saddle:    'painful'}
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#BicycleTest#**
   **[green]#PASS#** __(0.00s)__  test_forces_subclasses_to_implement_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_includes_local_spares_in_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_chain
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_tire_size
 Finished in 0.00027s
 8 tests, 8 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#


#################################
# Prove the test double honors the interface this
#   test expects.
class BikeDoubleTest < Minitest::Test
  include BicycleSubclassTest

  def setup
    @object = BikeDouble.new
  end
end

Minitest.run
Minitest::Runnable.reset
 **[rubyclass]#BikeDoubleTest#**
   **[green]#PASS#** __(0.00s)__  test_responds_to_default_tire_size
   **[green]#PASS#** __(0.00s)__  test_responds_to_local_spares
   **[green]#PASS#** __(0.00s)__  test_responds_to_post_initialize
 Finished in 0.00015s
 3 tests, 3 assertions, [green]#0 failures, 0 errors#, [yellow]#0 skips#
