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

  validate :belongs_to_at_least_one_family

  def belongs_to_at_least_one_family
    if family_posts.length < 1
      errors.add(:family_ids, "requires at least one family")
    end
  end
end
