class Post < ActiveRecord::Base
  belongs_to :user
  has_many :family_posts, dependent: :destroy
  has_many :families, through: :family_posts
  has_many :comments, inverse_of: :post, dependent: :destroy
  has_many :post_images, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :post_images, reject_if: :all_blank
  has_many :post_videos, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :post_videos, reject_if: :all_blank

  validates :user, presence: true
  validates :title, presence: true, length: {minimum: 2, maximum: 255}
end
