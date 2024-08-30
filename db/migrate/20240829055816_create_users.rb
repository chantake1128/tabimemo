class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string  :nickname,           nill: false
      t.string  :email,              nill: false, unique: true
      t.string  :encrypted_password, null: false, default: ""
      t.integer :phone_number,       nill: false, unique: true
      t.date    :birth_day,          nill: false
      t.timestamps
    end
  end
end
