class Invitee < ActiveRecord::Base
  belongs_to :family
  belongs_to :user

  validates :name, presence: true
  validates :email, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending joined) }
  validates :family, presence: true

  def make_family_member
    FamilyMember.create(family: self.family, user: self.user)
    Post.create(user: self.user, title: "#{self.user.first_name} joined the family!")
  end
end
