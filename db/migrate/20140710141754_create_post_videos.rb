class CreatePostVideos < ActiveRecord::Migration
  def change
    create_table :post_videos do |t|
      t.integer :post_id, null: false
      t.string :title
      t.string :url, null: false

      t.timestamps
    end
  end
end
