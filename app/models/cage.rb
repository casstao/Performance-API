class Cage < ApplicationRecord
  has_many :dinos
  validates :max_capacity, presence: true
  validates :current_capacity, presence: true
  validates :status, presence: true
  validates :cage_type, presence: true
end
