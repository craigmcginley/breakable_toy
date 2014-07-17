class AddEventDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :event_date, :date, null: false
  end
end
