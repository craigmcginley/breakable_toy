require 'rails_helper'

describe FamilyMember do

  it "#family" do
    family = FactoryGirl.create(:family)
    should have_valid(:family).when(family)
    should_not have_valid(:family).when(nil)
  end

  it "#user" do
    user = FactoryGirl.create(:user)
    should have_valid(:user).when(user)
    should_not have_valid(:user).when(nil)
  end

end
