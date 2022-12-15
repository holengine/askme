class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true,
                    uniqueness: true
  validates :nickname, format: { with: /\A[a-z_]+\z/ },
                       length: { maximum: 40 },
                       uniqueness: true
  def downcase_nickname
    nickname.downcase!
  end
end
