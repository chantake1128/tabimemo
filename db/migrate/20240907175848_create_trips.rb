class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string     :travel_name,   null: false
      t.integer    :prefecture_id, null: false
      t.date       :start_date,    null: false
      t.date       :end_date,      null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
