class Friendship < ApplicationRecord
  enum status: %i[pending accepted rejected]
  validates :requester, presence: true
  validates :requestee, presence: true

  before_save :insert_friendship
  belongs_to :requester, class_name: :User
  belongs_to :requestee, class_name: :User

  private

  def insert_friendship
    self.relation = requester_id > requestee_id ? "#{requestee_id}|#{requester_id}" : "#{requester_id}|#{requestee_id}"
  end
end
