class CreatePostImageUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :post_image_users do |t|
      t.string :image_id
      t.integer :user_id

      t.timestamps
    end
  end
end
