class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_and_belongs_to_many :tags

  validates :body, length: { maximum: 280 }, presence: true

  after_save_commit :create_tags

  private

  def create_tags
    question_tags = Question.find_by(id: self.id).tags

    question_tags.clear

    "#{self.body} #{self.answer}".scan(/#[[:word:]-]+/).uniq.each do |hashtag|
      question_tags << Tag.find_or_create_by(body: hashtag.gsub('#', '').downcase)
    end
  end
end
