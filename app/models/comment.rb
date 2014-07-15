class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :post, inverse_of: :comments

  validates :user, presence: true
  validates :post, presence: true
  validates :body, presence: true, length: {minimum: 1, maximum: 1000}
end

def correct_user_or_admin(current_user)
  admin_for = FamilyMember.where(user: current_user, role: "admin")

  if admin_for.empty?
    @comment = current_user.comments.find(params[:id])
  else
    @comment = Comment.find(params[:id])
    admin_for.each do |member|
      if @comment.user.families.include?(member.family)
        return @comment
      end
    end
    @comment = nil
  end
end
