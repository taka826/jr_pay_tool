## users

| Column             | Type       | Options          |
| ------------------ | ---------- | ---------------- |
| encrypted_password | string     | null: false      |
| email              | string     | null: false      |
| nickname           | string     | null: false      |

### Association
has_many :railways
has_many :comments


## railways

| Column             | Type       | Options                              |
| ------------------ | ---------- | ------------------------------------ |
| text               | string     | null: false                          |
| user_id            | integer    | foreign_key: true, null: false       |

### Association
belongs_to :user
has_many :comments

## comments

| Column             | Type       | Options           |
| ------------------ | ---------- | ----------------- |
| user_id            | integer    |                   |
| railway_id         | integer    |                   |
| text               | text       | null: false       |

### Association
belongs_to :railway
belongs_to :user