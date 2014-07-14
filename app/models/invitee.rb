class Invitee < ActiveRecord::Base
  belongs_to :family
  belongs_to :user

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: "family_id", message: "This invite already exists." }
  validate :family_member_does_not_exist_already, if: Proc.new { |i| i.family.present? }
  validates :status, presence: true, inclusion: { in: %w(pending joined) }
  validates :family, presence: true

  def family_member_does_not_exist_already
    family.family_members.each do |member|
      if member.user.email == self.email
        errors.add(:email, "This family member already exists.")
      end
    end
  end

end
