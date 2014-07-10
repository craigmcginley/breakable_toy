class Family < ActiveRecord::Base
  has_many :family_members, dependent: :destroy
  has_many :users, through: :family_members
  has_many :family_posts, dependent: :destroy
  has_many :posts, through: :family_posts
end
