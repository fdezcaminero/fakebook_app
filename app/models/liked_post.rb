class LikedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, uniqueness: { scope: %I[user_id post_id] }
end
