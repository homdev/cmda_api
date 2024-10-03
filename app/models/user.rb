class User < ApplicationRecord
  # Enum for roles
  enum role: { user: 0, member: 1, moderator: 2, admin: 3 }

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :name, presence: true
  validates :surname, presence: true
  validates :profession, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :profile_image_url, format: URI.regexp(%w[http https]), allow_nil: true
  validates :phone_number, format: { with: /\A\+?[0-9]{7,15}\z/, message: "must be a valid phone number" }, allow_nil: true

  # Custom validations
  validate :banner_image_metadata_valid

  private

  # Custom validation method for banner metadata
  def banner_image_metadata_valid
    if banner_image_metadata.present?
      # Check if it's a valid JSON format
      errors.add(:banner_image_metadata, "must be a valid JSON") unless valid_json?(banner_image_metadata)
    end
  end

  def valid_json?(json_string)
    JSON.parse(json_string)
    true
  rescue JSON::ParserError
    false
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
