class AddRoleToFamilyMembers < ActiveRecord::Migration
  def change
    add_column :family_members, :role, :string, default: "member", null: false
  end
end
