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
end
