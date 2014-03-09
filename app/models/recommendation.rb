class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  default_scope { order("created_at DESC") }

  validates :body, presence: true
  validates :user_id, presence: true
  validates :creator_id, presence: true
end