class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :query
      t.float :latitude
      t.float :longitude
      t.string :label

      t.timestamps
    end
  end
end
