class Tag < ApplicationRecord
  has_and_belongs_to_many :questions

  validates :body, length: {maximum: 50}
end
