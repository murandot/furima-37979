# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計

## usersテーブル

| Column                | Type      | Options                        |
|-----------------------|-----------|--------------------------------|
| nickname              | string    | null: false                    |
| email                 | string    | null: false                    |
| encrypted_password    | text      | null: false, unique: true      |
| last_name             | string    | null: false                    |
| first_name            | string    | null: false                    |
| birthday              | date      | null: false                    |

### Association

- has_many :items
- has_many :orders



## itemsテーブル
| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| name                  | string     | null: false                    |
| content               | text       | null: false                    |
| category_id           | integer    | null: false                    |
| status_id             | integer    | null: false                    |
| fee_id                | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| schedule_id           | integer    | null: false                    |
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order



## ordersテーブル
| Column                | Type      | Options                        |
|-----------------------|-----------|--------------------------------|
| user                  | reference | null: false, foreign_key: true |
| item                  | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address



## addressesテーブル
| Column                | Type      | Options                        |
|-----------------------|-----------|--------------------------------|
| postal_code           | integer   | null: false                    |
| prefecture            | integer   | null: false                    |
| city                  | string    | null: false                    |
| house_number          | string    | null: false                    |
| building_name         | string    | null: false                    |
| phone_number          | integer   | null: false                    |

### Association

- belongs_to :order