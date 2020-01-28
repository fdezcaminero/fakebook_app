class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :liked_posts, dependent: :destroy
  has_many :like_comments, dependent: :destroy
  has_many :comments

  friendship_scope = -> { includes(:requester, :requestee).order('users.username') }
  has_many :following_friendships, friendship_scope, foreign_key: 'requester_id', class_name: :Friendship
  has_many :followers_friendships, friendship_scope, foreign_key: 'requestee_id', class_name: :Friendship

  validates :username, presence: true, length: { maximum: 50, minimum: 3 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Requests made by others to current_user
  def active_followers
    followers_friendships.where(status: :accepted).map(&:requester)
  end

  def pending_followers
    followers_friendships.where(status: :pending).map(&:requester)
  end

  # Requests made by current_user to others
  def pending_following
    following_friendships.where(status: :pending).map(&:requestee)
  end

  def active_following
    following_friendships.where(status: :accepted).map(&:requestee)
  end

  def rejected_followings
    following_friendships.where(status: :rejected).map(&:requestee)
  end

  def rejected_followers
    followers_friendships.where(status: :rejected).map(&:requester)
  end

  def remove_friendship(friend_id)
    following_friendships.find_by_requestee_id(friend_id)&.destroy ||
      followers_friendships.find_by_requester_id(friend_id)&.destroy
  end
end
