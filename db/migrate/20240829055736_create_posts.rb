class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string     :title,       null: false
      t.text       :body,        null: false
      t.integer    :category_id, null: false
      t.integer    :status_id,   null: false
      t.integer    :score_id,    null: false
      t.references :user,        null: false, foreign_key: true
      t.references :landmark,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
