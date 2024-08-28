
# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| last_name1         | string   | null: false               |
| first_name1        | string   | null: false               |
| last_name2         | string   | null: false               |
| first_name2        | string   | null: false               |
| year_id            | integer  | null: false               |
| month_id           | integer  | null: false               |
| day_id             | integer  | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :comments


### items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user_id          | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| explanation      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| situation_id     | integer    | null: false                    |
| load_id          | integer    | null: false                    |
| region_id        | integer    | null: false                    |
| delivery_id      | integer    | null: false                    |
| price            | string     | null: false                    |

### Association

- belongs_to :user
- has_one :purchase
- has_many :comments

## orders テーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| user_id      | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| price        | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## address テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| orders             | references | null: false, foreign_key: true |
| postcode           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipality       | string     | null: false                    |
| house_number       | text       | null: false                    |
| building           | text       | null: false                    |
| phone              | text       | null: false                    |

### Association

- belongs_to :order

## comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user_id      | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| text         | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
