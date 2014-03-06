class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  scope :pending_friends, -> { where status: "pending" }
  scope :requested_friends, -> { where status: "requested" }

  validates :user_id, presence: true
  validates :friend_id, presence: true

  def self.are_friends(user, friend)
    return false if user == friend
    unless Friendship.find_by(user: user, friend: friend).nil? || Friendship.find_by(user: friend, friend: user).nil?
      return true
    end
    false
  end

  def self.request(user, friend)
    return false if Friendship.are_friends(user,friend) || user == friend
    friend1 = Friendship.new(user: user, friend: friend, status: "pending")
    friend2 = Friendship.new(user: friend, friend: user, status: "requested")
    transaction do
      friend1.save
      friend2.save
    end
    true
  end

  def self.accept(user, friend)
    friend1 = Friendship.find_by(user: user, friend: friend)
    friend2 = Friendship.find_by(user: friend, friend: user)
    return false if friend1.nil? || friend2.nil?
    transaction do
      friend1.update(status: "accepted")
      friend2.update(status: "accepted")
    end
    true
  end

  def self.reject(user, friend)
    friend1 = Friendship.find_by(user: user, friend: friend)
    friend2 = Friendship.find_by(user: friend, friend: user)
    return false if friend1.nil? || friend2.nil?
    transaction do
      friend1.destroy
      friend2.destroy
      true
    end
  end
end
