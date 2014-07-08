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

end
