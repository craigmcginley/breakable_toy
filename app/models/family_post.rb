class FamilyPost < ActiveRecord::Base
  belongs_to :family
  belongs_to :post
end
