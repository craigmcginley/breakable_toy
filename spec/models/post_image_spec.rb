require 'rails_helper'

describe PostImage do

  it "#post" do
    post = FactoryGirl.create(:post)
    should have_valid(:post).when(post)
    should_not have_valid(:post).when(nil)
  end

  describe "#title" do
    it { should have_valid(:title).when(nil, "", "Family Pic 2014", "Craig at Summer Camp!") }
    it { should_not have_valid(:title).when("Title too Long" * 50) }
  end

  describe "#url" do
    it { should_not have_valid(:url).when("", nil) }
  end

end
