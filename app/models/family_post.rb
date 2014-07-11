class FamilyPost < ActiveRecord::Base
  belongs_to :family
  belongs_to :post

  validates :family, presence: true
  validates :post, presence: true
end
