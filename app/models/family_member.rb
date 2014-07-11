class FamilyMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :family

  validates :user, presence: true
  validates :family, presence: true
  validates :role, presence: true, inclusion: { in: %w(member admin) }
end
