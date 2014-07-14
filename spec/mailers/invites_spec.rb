require "rails_helper"

RSpec.describe Invites, :type => :mailer do

  describe "invite" do
    user = FactoryGirl.build(:user)
    family = FactoryGirl.build(:family)
    invitee = FactoryGirl.build(:invitee)
    invitee.user_id = user.id
    invitee.family_id = family.id
    let(:mail) { Invites.invite(invitee, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation from #{user.first_name} to join a kinstagram family")
      expect(mail.to).to eq([invitee.email])
      expect(mail.from).to eq(["invites@kinstagram.us"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_content("#{user.first_name} #{user.last_name} has invited you to join their family group on kinstagram. Register or sign in to accept this invitation.")
      expect(mail.body.encoded).to have_content("Sign in")
      expect(mail.body.encoded).to have_content("sign up")
    end
  end

end
