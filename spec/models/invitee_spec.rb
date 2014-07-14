require 'rails_helper'

describe Invitee do

  it "#family" do
    family = FactoryGirl.create(:family)
    should have_valid(:family).when(family)
    should_not have_valid(:family).when(nil)
  end

  describe "#name" do
    it { should have_valid(:name).when("Craig", "John Paul") }
    it { should_not have_valid(:name).when(nil, "") }
  end

  describe "#email" do
    it { should have_valid(:email).when("craig@example.com") }
    it { should_not have_valid(:email).when(nil, "") }
  end

  describe "#status" do
    it { should have_valid(:status).when("pending", "joined") }
    it { should_not have_valid(:status).when(nil, "", "derp") }
  end

end
