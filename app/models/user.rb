class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :family_posts, through: :families
  has_many :visible_posts,
    through: :family_posts,
    source: :post

  has_many :posts
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
