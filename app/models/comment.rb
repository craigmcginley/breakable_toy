class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments

  validates :user, presence: true
  validates :post, presence: true
  validates :body, presence: true, length: {minimum: 1, maximum: 1000}
end
