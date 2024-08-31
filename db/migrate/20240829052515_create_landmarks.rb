class CreateLandmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :landmarks do |t|
      t.string  :name,           null: false
      t.integer :prefecture_id,  null: false
      t.string  :city,           null: false
      t.string  :street_address, null: false
      t.string  :building_name
      t.timestamps
    end
  end
end
