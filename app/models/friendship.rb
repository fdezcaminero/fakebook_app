class Friendship < ApplicationRecord
  enum status: %i[pending accepted rejected]
  belongs_to :requester, class_name: :User
  belongs_to :requestee, class_name: :User

  validates :requester, presence: true
  validates :requestee, presence: true
  validate :self_friendship_check
  validate :duplicate_friendship_check

  private

  def inject_friendship
    if requester_id > requestee_id
      self.relation = "#{requestee_id}|#{requester_id}"
    else
      self.relation = "#{requester_id}|#{requestee_id}"
    end
  end

  def self_friendship_check
    errors.add(:requestee_id, 'Cant friend yourself') if requester_id == requestee_id
  end

  def duplicate_friendship_check
    friendship_requester = Friendship.where(requester_id: requestee_id, requestee_id: requester_id).exists?
    friendship_requestee = Friendship.where(requester_id: requester_id, requestee_id: requestee_id).exists?
    errors.add(:requester_id, 'Already friends!') if friendship_requester && friendship_requestee
  end
end
