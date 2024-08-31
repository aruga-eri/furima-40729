
# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| last_name         | string   | null: false               |
| first_name        | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birthday           | date      | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :comments


### items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| explanation      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| situation_id     | integer    | null: false                    |
| load_id          | integer    | null: false                    |
| delivery_id      | integer    | null: false                    |
| prefecture_id      | integer    | null: false                  |
| price            | integer     | null: false                   |

### Association

- belongs_to :user
- has_one :purchase
- has_many :comments

##  purchasesテーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| purchase           | references | null: false, foreign_key: true |
| postcode           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipality       | string     | null: false                    |
| house_number       | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |

### Association

- belongs_to :purchase

## comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| text         | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
