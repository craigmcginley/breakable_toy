require 'rails_helper'

describe Post do

  it "#user" do
    user = FactoryGirl.create(:user)
    should have_valid(:user).when(user)
    should_not have_valid(:user).when(nil)
  end

  describe "#title" do
    it { should have_valid(:title).when("Just an Update", "Hey Everyone!") }
    it { should_not have_valid(:title).when(nil, "", "Title too Long" * 50) }
  end

  describe "#body" do
    it { should have_valid(:body).when("This is a test body.", "We had so much fun the other day!" * 50) }
  end

  describe "#event_date" do
    it { should have_valid(:event_date).when("01/01/2000", Date.today ) }
    it { should_not have_valid(:event_date).when("fadsjkh", "01/01/5000", "10102000", "01/012000", 01, nil, "") }
  end


end
