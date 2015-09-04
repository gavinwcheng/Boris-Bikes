require 'docking_station'

describe DockingStation do
	it { expect(subject).to respond_to :release_bike }
	it "releases working bikes" do
    bike = double :bike, working?:true
		subject.dock bike
		# expect(subject.release_bike).to be_an_instance_of(Bike)
		expect(subject.release_bike bike).to be_working
	end
  it { expect(subject).to respond_to(:dock).with(1).argument }
  it "has a default capacity" do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

	describe "#release_bike" do
    it "raises an error when there are no bikes available" do
      bike = :bike
			expect { subject.release_bike bike }.to raise_error "No bikes available"
		end

    it "raises an error when asked to release broken bike" do
    	bike = double :bike, working?: false
			subject.dock bike
			expect { subject.release_bike bike }.to raise_error "Bike is broken"
    end
	end

  describe "#dock" do
    it "raises an error when full" do
    	subject.capacity.times { subject.dock(:bike) }
			expect { subject.dock(:bike) }.to raise_error "Docking station full"
    end

		it "raises an error when not bike" do
      expect { subject.dock(:bike) }.to raise_error "Not bike!"
		end
  end

	it "set_capacity changes docking station capacity" do
		subject.capacity = 15
		expect(subject.capacity).to equal 15
	end

	it { expect(subject).to respond_to :release_broken_bikes}

	it "releases all the broken bikes to be collected by van" do
    bike1 = Bike.new
		bike2 = Bike.new
		bike1.not_working
		subject.dock bike1
		subject.dock bike2
		broken_bikes = subject.release_broken_bikes
		expect(subject.bikes.select{|bike| bike.working? == false}).to eq broken_bikes
	end

	it { expect(subject).to respond_to :remove_broken_bikes}


end
