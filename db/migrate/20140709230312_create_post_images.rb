class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.integer :post_id, null: false
      t.string :url, null: false
      t.string :title

      t.timestamps
    end
  end
end
