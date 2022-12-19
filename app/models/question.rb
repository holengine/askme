class Question < ApplicationRecord
  belongs_to :user

  validates :body, length: { maximum: 280 }, presence: true
end
