class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.date :date, null: false
      t.timestamps
      t.references :trip,    null: false, foreign_key: true
    end
  end
end
