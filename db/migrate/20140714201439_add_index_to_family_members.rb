class AddIndexToFamilyMembers < ActiveRecord::Migration
  def change
    add_index(:family_members, [:user_id, :family_id], unique: true)
  end
end
