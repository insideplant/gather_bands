class AddBandIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :band_id, :integer
  end
end
