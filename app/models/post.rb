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
  validates :event_date, presence: true, timeliness: { on_or_before: lambda { Date.current }, type: :date }
  validates :title, presence: true, length: {minimum: 2, maximum: 255}

  validate :belongs_to_at_least_one_family

  def belongs_to_at_least_one_family
    if family_posts.length < 1
      errors.add(:family_ids, "requires at least one family")
    end
  end

  def self.find_for_user_or_admin(id, current_user)
    admin_for = FamilyMember.where(user: current_user, role: "admin")

    if admin_for.empty?
      current_user.posts.find_by(id: id)
    else
      post = Post.find_by(id: id)
      admin_for.each do |member|
        if post.user.families.include?(member.family)
          return post
        end
      end
      nil
    end
  end
end
