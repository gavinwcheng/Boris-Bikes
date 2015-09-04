require 'bike'
require 'spec_helper'


describe Bike do
	it { expect(subject).to respond_to(:working?) }

	it { expect(subject).to respond_to(:not_working) }

	it "sets bike to be not working" do
  	subject.not_working
		expect(subject.working?).to be false
  end
end
