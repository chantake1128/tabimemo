# アプリケーション名
tabimemo

# アプリケーション概要
ユーザーが旅行情報の登録と旅のしおり（旅行計画）を立てることができます。

# URL
https://tabimemo.onrender.com

# 利用方法
## 観光地情報登録
1.トップページのヘッダーにある「新規登録」ボタンをクリックし、ユーザー登録を行う
2.行きたい都道府県をクリックする
3.画面右下の「観光地登録」をクリック
4.各種項目を記入（画像、ビル名以外は必須）
5.投稿するボタンをクリックして投稿する

## 旅行情報登録
1.トップページのヘッダーにある「新規登録」ボタンをクリックし、ユーザー登録を行う
2.行きたい都道府県をクリックする
3.画面右下の「旅行情報登録」をクリック
4.各種項目を記入（すべて必須のため要入力）

## 旅のしおり（旅行計画）の作成
未実装

## いいねの追加、削除
### 追加
旅行情報欄にある「いいねする」をクリックすると登録できる
### 削除
いいねが登録されている場合「いいね済」と表示される
「いいね済」をクリックすると削除できる
※JavaScriptの実装中（現在はロードが入る）

# 機能一覧
| 機能                  | ログインユーザー | 非ログインユーザー |
|-----------------------|-----------------|-------------------|
| ユーザー登録           | 〇              | X                |
| ユーザー編集           | 〇              | X                |
| 旅行情報閲覧機能       | 〇              | 〇               |
| 旅行情報詳細閲覧機能   | 〇              | 〇               |
| 旅行情報編集機能       | 〇              | X                |
| 旅行情報削除機能       | 〇              | X                |
| 旅行情報投稿機能       | 〇              | X                |
| 観光地登録機能         | 〇              | X                |
| 旅のしおり閲覧機能     | 〇              | 〇               |
| 旅のしおり詳細閲覧機能 | 〇              | 〇               |
| 旅のしおり登録機能     | 〇              | X                |
| 旅のしおり投稿機能     | 〇              | X                |
| 旅のしおり編集機能     | 〇              | X                |
| 旅のしおり削除機能     | 〇              | X                |
| コメント機能           | 〇              | X                |

# アプリケーションを作成した背景
## 旅行情報掲載×旅行計画を作りたい
### ユーザーが旅行の情報を投稿できるサイトが少ない
・旅行をする際実際に目にするのはメジャーなものばかりで穴場が掲載されていない
・旅行に行った人が見つけた場所を共有する場所を作りたい

### 旅行計画を作る際手間がかかる
・サイトを見て、メモに記載など複数のサイト、アプリを往復する必要がある
・どちらも同じサイトで手間の削減をしたい

# 実装予定の機能
・ユーザー同士でグループを作成。グループでの旅のしおり共有機能
・観光地情報の管理者限定削除、編集機能
・旅行情報登録時に登録したい観光地の情報がない場合登録画面に遷移できる機能
・旅行情報登録時に都道府県ごとに観光地情報にフィルターをかける
・旅行情報登録時に観光地情報登録時の検索機能実装
# 開発環境
## フロントエンド
・HTML
・CSS
・JavaScript

## バックエンド
・Ruby(3.2.0)
・Ruby on Rail(7.0.0)

# ローカルでの動作方法
% git clone https://github.com/chantake1128/tabimemo.git
% cd quiz-square
% yarn
% yarn dev

# 工夫した点
・トップページで都道府県を選択できるようにした
・一覧表示画面で選択された都道府県でフィルターをかけた
・旅行情報と旅のしおりを同時に表示している

# テーブル情報
<!-------------------------------ユーザー情報------------------------------------>
## usersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| nickname           | string              | null: false                    |
| email              | string              | null: false, unique: true      |
| encrypted_password | string              | null: false, unique: true      |
| phone_number       | integer             | null: false, unique: true      |
| birth_day          | date                | null: false                    |

### Association
- has_many :posts
- has_many :comments
- has_many :landmarks

<!-------------------------------投稿情報-------------------------------------->
## postsテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| title              | string              | null: false                    |
| body               | text                | null: false                    |
| category_id        | integer             | null: false                    |
| status_id          | integer             | null: false                    |
| score_id           | integer             | null: false                    |
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
| text               | text                | null: false                    |
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
| city               | string              | null: false                    |
| street_address     | string              | null: false                    |
| building_name      | string              |                                |

### Association

# ActiveHashの関連付け
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :city

# その他の関連付け
- has_one    :post
- belongs_to :user

<!--------------------------------旅行計画（全体）-------------------------------------->
## tripsテーブル
| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| travel-name        | string              | null: false                    |
| prefecture_id      | integer             | null: false                    |
| start-date         | date                | null: false                    |
| end-date           | date                | null: false                    |
| user               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :user
- has_many   :schedules

<!--------------------------------スケジュール（日程）----------------------------------->
## schedulesテーブル
| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| date               | date                | null: false                    |
| trip               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :trip
- has_many   :activities


<!--------------------------------アクティビティー（時間）------------------------------->
# activitiesテーブル
| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| start-time         | integer             | null: false                    |
| end-time           | integer             | null: false                    |
| location           | string              | null: false                    |
| description        | string              |                                |
| schedule           | references          | null: false, foreign_key:true  |

### Association
- belongs_to :schedule
