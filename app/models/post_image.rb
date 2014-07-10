class PostImage < ActiveRecord::Base
  mount_uploader :url, PostImageUploader

  belongs_to :post

  validates :url, presence: true
  validates :post, presence: true
end
