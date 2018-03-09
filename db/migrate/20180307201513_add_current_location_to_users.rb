class AddCurrentLocationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_location, :integer
  end
end
