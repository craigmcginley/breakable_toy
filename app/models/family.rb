class Family < ActiveRecord::Base
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members
  has_many :family_posts, dependent: :destroy
  has_many :posts, through: :family_posts
  has_many :invitees

  validates :surname, presence: true, length: {minimum: 2, maximum: 60}
end
