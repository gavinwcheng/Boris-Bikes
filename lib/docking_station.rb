require_relative 'bike'

class DockingStation
	DEFAULT_CAPACITY = 20

	attr_accessor :capacity

	def initialize
		@bikes = []
	  @capacity = DEFAULT_CAPACITY
	end

	def release_bike(bike)
		fail "No bikes available" if empty?
		fail "Bike is broken" if bike.working? == false
    @bikes.pop
	end

  def dock (bike)
    fail "Docking station full" if full?
    @bikes.push bike
  end

  private

	def full?
	  @bikes.count >= @capacity
	end

  def empty?
	  @bikes.empty?
	end

end
