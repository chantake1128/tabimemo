class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.integer :start_time,  null: false
      t.integer :end_time,    null: false
      t.string  :location,    null: false
      t.string  :description
      t.references :trip,     null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.timestamps
    end
  end
end
