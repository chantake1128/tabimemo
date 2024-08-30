class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname, nill: false
      t.string :email,    nill: false, unique: true
      
      t.timestamps
    end
  end
end
