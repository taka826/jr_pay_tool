class Comment < ApplicationRecord
  belongs_to :railway
  belongs_to :user
end
