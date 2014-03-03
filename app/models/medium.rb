class Medium < ActiveRecord::Base
  belongs_to :user

  scope :current_media, -> { where(status: "Current") }
  scope :wish_list, -> { where(status: "Wish List") }
  scope :finished, -> { where(status: "Finished") }

  validates :title, presence: true
  validates :status, presence: true
  validates :category, presence: true
end
