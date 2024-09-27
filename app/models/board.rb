class Board < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :title, length: { minimum: 5 }
  validates :description, length: { minimum: 20 }
end
