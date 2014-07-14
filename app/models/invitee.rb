class Invitee < ActiveRecord::Base
  belongs_to :family
  belongs_to :user

  validates :name, presence: true
  validates :email, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending joined) }
  validates :family, presence: true

  def make_family_member
    all_memberships = FamilyMember.all
    new_member = FamilyMember.new(family: self.family, user: self.user)
    if !all_memberships.include?(new_member)
      new_member.save
      Post.create(user: self.user, title: "#{self.user.first_name} joined the family!")
    end
  end

  def already_exists?
    users_invites = Invitee.where(email: self.email)
    users_invites.each do |invite|
      if invite.family == self.family
        return true
      end
    end

    self.family.family_members.each do |member|
      if member.user.email == self.email
        return true
      end
    end
    return false
  end

end
