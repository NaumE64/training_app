class User < ApplicationRecord
  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  validates :email, uniqueness: true, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }


  def public_name
    [first_name, last_name].join(' ')
  end
end
