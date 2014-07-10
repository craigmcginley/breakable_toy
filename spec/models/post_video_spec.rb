require 'rails_helper'

describe PostVideo do

  it "#post" do
    post = FactoryGirl.create(:post)
    should have_valid(:post).when(post)
    should_not have_valid(:post).when(nil)
  end

  describe "#title" do
    it { should have_valid(:title).when(nil, "", "Recital 2014") }
    it { should_not have_valid(:title).when("Title too Long" * 20) }
  end

  describe "#url" do
    it { should_not have_valid(:url).when("", nil) }
  end

end
