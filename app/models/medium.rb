class Medium < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true
  validates :category, presence: true
end
