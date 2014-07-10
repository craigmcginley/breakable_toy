class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_images
  accepts_nested_attributes_for :post_images, reject_if: :all_blank

  validates :user, presence: true
  validates :title, presence: true, length: {minimum: 2, maximum: 255}
end
