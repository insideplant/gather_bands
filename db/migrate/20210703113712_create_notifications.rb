class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :live_id
      t.integer :live_organization_id
      t.integer :article_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :live_id
    add_index :notifications, :live_organization_id
    add_index :notifications, :article_id
    add_index :notifications, :comment_id
  end
end
