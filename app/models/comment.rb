class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
