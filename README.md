<!-------------------------------ユーザー情報------------------------------------>
## usersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| nickname           | string              | nill: false                    |
| email              | string              | nill: false, unique: true      |
| encrypted_password | string              | nill: false, unique: true      |
| phone_number       | integer             | nill: false, unique: true      |
| birth_day          | date                | nill: false                    |

### Association
- has_many :posts
- has_many :comments

<!-------------------------------投稿情報-------------------------------------->
## postsテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| title              | string              | nill: false                    |
| body               | text                | nill: false                    |
| category_id        | integer             | nill: false                    |
| status_id          | integer             | nill: false                    |
| score_id           | integer             | nill: false                    |
| user               | references          | null: false, foreign_key:true  |
| landmark           | references          | null: false, foreign_key:true  |

### Association

# ActiveHashの関連付け
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :score

# その他の関連付け
- belongs_to :user
- has_many :comments
- belongs_to :landmark


<!-------------------------------コメント-------------------------------------->
## commentsテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| text               | text                | nill: false                    |
| user               | references          | null: false, foreign_key:true  |
| post               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :user
- belongs_to :post


<!-------------------------------観光地情報------------------------------------->
## landmarksテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| prefecture_id      | integer             | null: false                    |
| city               | string                 | null: false                    |
| street_address     | string              | null: false                    |
| building_name      | string              |                                |

### Association

# ActiveHashの関連付け
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :city

# その他の関連付け
- has_one :post