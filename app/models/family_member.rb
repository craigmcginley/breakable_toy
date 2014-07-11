class FamilyMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :family

  validates :user, presence: true
  validates :family, presence: true
end
