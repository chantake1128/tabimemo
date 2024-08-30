class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string     :title, nill: false
      t.text       :body,  nill: false
      t.integer    :category_id, nill: false
      t.integer    :status_id,   nill: false
      t.integer    :score_id,    nill: false
      t.references :user,        nill: false, foreign_key: true
      t.references :landmark,    nill: false, foreign_key: true
      t.timestamps
    end
  end
end
