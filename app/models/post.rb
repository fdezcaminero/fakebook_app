class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..1500 }
  validates :user, presence: true
end
