class CreateFamilyPosts < ActiveRecord::Migration
  def change
    create_table :family_posts do |t|
      t.integer :family_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
