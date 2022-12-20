class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :body, length: { maximum: 280 }, presence: true
end
