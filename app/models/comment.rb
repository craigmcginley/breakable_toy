class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments

  validates :user, presence: true
  validates :post, presence: true
  validates :body, presence: true, length: {minimum: 1, maximum: 1000}

  def self.find_for_user_or_admin(id, current_user)
    admin_for = FamilyMember.where(user: current_user, role: "admin")

    if admin_for.empty?
      current_user.comments.find_by(id: id)
    else
      comment = Comment.find_by(id: id)
      admin_for.each do |member|
        binding.pry
        if comment.user.families.include?(member.family)
          return comment
        end
      end
      nil
    end
  end
end
