class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :family_posts, through: :families
  has_many :visible_posts,
    through: :family_posts,
    source: :post

  has_many :invitees
  has_many :posts
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def deletable_comment?(comment)
    if comment.user == self
      return true
    end
    family_members.each do |membership|
      comment.post.families.each do |family|
        if family == membership.family && membership.role == "admin"
          return true
        end
      end
    end
    return false
  end

  def deletable_post?(post)
    if post.user == self
      return true
    end
    family_members.each do |membership|
      post.families.each do |family|
        if family == membership.family && membership.role == "admin"
          return true
        end
      end
    end
    return false
  end


  def admin_of?(family)
    family_members.each do |membership|
      if membership.family == family && membership.role == "admin"
        return true
      end
    end
    return false
  end

  def grab_invitations
    invites = []
    families.each do |fam|
      fam.invitees.each do |invite|
        invites << invite
      end
    end
    invites
  end
end
