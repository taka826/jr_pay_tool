class Railway < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_one_attached :image
  has_many :comments

  def self.search(search)
    if search != ""
      Railway.where('text LIKE(?)', "%#{search}%")
    else
      Railway.all
    end
  end
end
