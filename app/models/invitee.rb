class Invitee < ActiveRecord::Base
  belongs_to :family

  validates :name, presence: true
  validates :email, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending joined) }
  validates :family, presence: true
end
