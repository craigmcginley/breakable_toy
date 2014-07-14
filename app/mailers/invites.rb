class Invites < ActionMailer::Base
  default from: "invites@kinstagram.us"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invites.invite.subject
  #
  def invite(invitee, inviter)
    @invitee = invitee
    @inviter = inviter

    mail to: invitee.email,
         subject: "Invitation from #{inviter.first_name} to join a kinstagram family"
  end
end
