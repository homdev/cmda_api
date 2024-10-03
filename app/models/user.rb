class User < ApplicationRecord
  enum role: { user: 0, member: 1, moderator: 2, admin: 3}

  # Validations, Devise modules, and relationships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
end
