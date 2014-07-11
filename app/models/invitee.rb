class Invitee < ActiveRecord::Base
  belongs_to :family

  validates :email, presence: true
  validates :status, presence: true, inclusion
end
