require 'rails_helper'

describe Family do

  describe "#surname" do
    it { should have_valid(:surname).when("McGinley", "D'Amour", "De Armond") }
    it { should_not have_valid(:surname).when(nil, "", "Name" * 25 ) }
  end

end
