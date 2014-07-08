class Post < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true, length: {minimum: 2, maximum: 255}
end
