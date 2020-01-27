class LikeComment < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: %i[user_id comment_id] }
end
