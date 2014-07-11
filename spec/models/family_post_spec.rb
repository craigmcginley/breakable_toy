require 'rails_helper'

describe FamilyPost do

  it "#family" do
    family = FactoryGirl.create(:family)
    should have_valid(:family).when(family)
    should_not have_valid(:family).when(nil)
  end

  it "#post" do
    post = FactoryGirl.build(:post)
    should have_valid(:post).when(post)
    should_not have_valid(:post).when(nil)
  end

end
