require 'docking_station'
require 'spec_helper'

describe DockingStation do
	it { expect(subject).to respond_to :release_bike }
	it "releases working bikes" do
    bike = Bike.new
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
      bike = Bike.new
			expect { subject.release_bike bike }.to raise_error "No bikes available"
		end

    it "raises an error when asked to release broken bike" do
    	bike = Bike.new
			bike.not_working
			subject.dock bike
			expect { subject.release_bike bike }.to raise_error "Bike is broken"
    end
	end

  describe "#dock" do
    it "raises an error when full" do
    	subject.capacity.times { subject.dock(Bike.new) }
			expect { subject.dock(Bike.new) }.to raise_error "Docking station full"
    end
  end

	it "set_capacity changes docking station capacity" do
		subject.capacity = 15
		expect(subject.capacity).to equal 15
	end
end
