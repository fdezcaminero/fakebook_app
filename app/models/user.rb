class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :liked_posts, dependent: :destroy
  has_many :like_comments, dependent: :destroy
  has_many :comments
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  validates :username, presence: true, length: { maximum: 50, minimum: 3 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friends
   friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}
   friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
   friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def remove_friendship(friend_id)
    friendships.find_by_friend_id(friend_id)&.destroy ||
    inverse_friendships.find_by_user_id(friend_id)&.destroy
  end
end
