class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :status, default: "pending", null: false
      t.integer :family_id, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
