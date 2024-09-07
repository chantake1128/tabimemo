class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.date :date, null: false
      t.timestamps
    end
  end
end
