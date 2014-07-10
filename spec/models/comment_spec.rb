require 'rails_helper'

describe Comment do

  it "#user" do
    user = FactoryGirl.create(:user)
    should have_valid(:user).when(user)
    should_not have_valid(:user).when(nil)
  end

  it "#post" do
    post = FactoryGirl.create(:post)
    should have_valid(:post).when(post)
    should_not have_valid(:post).when(nil)
  end

  describe "#body" do
    it { should have_valid(:body).when("This is a test body.") }
    it { should_not have_valid(:body).when(nil, "", "We had so much fun the other day!" * 50) }
  end

end
