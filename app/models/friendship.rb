class Friendship < ApplicationRecord
  enum status: %i[pending accepted rejected]
  belongs_to :requester, class_name: :User
  belongs_to :requestee, class_name: :User

  validates :requester, presence: true
  validates :requestee, presence: true
  validate :disallow_self_friendship
  validate :duplicate_check

  private

  def disallow_self_friendship
    errors.add(:requestee_id, 'Cant friend yourself') if requester_id == requestee_id
  end

  def duplicate_check
    friendship_requester = Friendship.where(requester_id: requestee_id, requestee_id: requester_id).exists?
    friendship_requestee = Friendship.where(requester_id: requester_id, requestee_id: requestee_id).exists?
    errors.add(:requester_id, 'Already friends!') if friendship_requester && friendship_requestee
  end
end
