class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :user_id
      t.integer :weather_id
    end
  end
end
