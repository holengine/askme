class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags

  validates :body, length: { maximum: 280 }, presence: true

  after_create do
    HashtagParser.parse(self.body).uniq.each do |hashtag|
      tag = Tag.find_or_create_by(body: hashtag[:text].downcase)
      Question.find_by(id: self.id).tags << tag
    end
  end

  before_update do
    Question.find_by(id: self.id).tags.clear
    HashtagParser.parse(self.body).uniq.each do |hashtag|
      tag = Tag.find_or_create_by(body: hashtag[:text].downcase)
      Question.find_by(id: self.id).tags << tag
    end
  end
end
