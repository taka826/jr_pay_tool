## users

| Column             | Type       | Options          |
| ------------------ | ---------- | ---------------- |
| encrypted_password | string     | null: false      |
| email              | string     | null: false      |

### Association
has_many :railways


## railways

| Column             | Type       | Options           |
| ------------------ | ---------- | ----------------- |
| junction_id        | integer    | null: false       |
| price              | integer    | null: false       |
| terminal_id        | integer    | null: false       |

### Association
belongs_to :user
