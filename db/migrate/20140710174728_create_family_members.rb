class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.integer :family_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
