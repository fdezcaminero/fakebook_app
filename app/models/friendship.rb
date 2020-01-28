class Friendship < ApplicationRecord
  enum status: %i[pending accepted rejected]
  belongs_to :requester, class_name: :User
  belongs_to :requestee, class_name: :User
  before_save :insert_friendship

  validates :requester, presence: true
  validates :requestee, presence: true

  private

  def insert_friendship
    self.relation = requester_id > requestee_id ? "#{requestee_id}|#{requester_id}" : "#{requester_id}|#{requestee_id}"
  end

  def disallow_self_friendship
    if requester_id == requestee_id
      errors.add(:requestee_id, "Cant friend yourself")
    end
  end

  def duplicate_check
    errors.add(:requester_id, 'Already friends!') if Friendship.where(
          requester_id: requestee_id, requestee_id: requester_id).exists? &&
          Friendship.where(requester_id: requester_id, requestee_id: requestee_id).exists?
  end
end
