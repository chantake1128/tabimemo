class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts

  validates :nickname,     presence: true
  validates :birth_day,    presence: true
  validate :validate_password_format, if: -> { password.present? }
  validate :valid_phone_number

  private

  def validate_password_format
    unless password =~ /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
      errors.add(:password, 'must include both letters and numbers')
    end
  end

  def valid_phone_number
    unless phone_number.present? && phone_number =~ /\A\d{10,11}\z/
      errors.add(:phone_number, "Please enter a valid 10-digit or 11-digit phone number")
    end
  end

end
