class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.string :temperature
      t.string :min_temperature
      t.string :max_temperature
      t.string :wind_speed
      t.integer :humidity
      t.string :condition
    end
  end
end
