class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  has_many :questions, dependent: :delete_all

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true,
                    uniqueness: true
  validates :nickname, format: { with: /\A\w*\z/ },
                       length: { maximum: 40 },
                       uniqueness: true

  validates :theme_color, format: { with: /\A#\h{6}\z/ }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
