class Habit < ApplicationRecord
  belongs_to :user

  has_many :checkins, dependent: :destroy
end
