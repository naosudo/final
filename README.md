# README  

## users テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false, unique: true |
| encrypted_password    | string  | null: false |
| firstname_kanji       | string  | null: false |
| lastname_kanji        | string  | null: false |
| firstname_katakana    | string  | null: false |
| lastname_katakana     | string  | null: false |
| birth_day             | date    | null: false |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column               | Type       | Options                        |
| ---------            | ---------- | ------------------------------ |
| name                 | string     | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false ,foreign_key: true |
| description          | text       | null: false                    |
| category_id          | integer    | null: false                    |
| status_id            | integer    | null: false                    |
| payment_id           | integer    | null: false                    |
| prefecture_id        | integer    | null: false                    |
| day_id              | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :order



## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item
has_one :address

## addresses テーブル

| Column         | Type       | Options                       |
| -------------- | ---------- | ----------------------------- |
| postal_code    | string     | null: false                   |
| prefecture_id  | integer    | null: false                   |
| city           | string     | null: false                   |
| house_number   | string     | null: false                   |
| building_name  | string     |                               |
| phone_number   | string     | null:false                    |
| order          | references | null:false, foreign_key: true |

### Association

- belongs_to :order
