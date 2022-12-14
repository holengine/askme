class Question < ApplicationRecord
  validates :body, length: {maximum: 280}, presence: true
end
