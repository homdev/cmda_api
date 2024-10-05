# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(email: 'admin@example.com', password: 'password', role: 'admin')
User.create!(email: 'moderator@example.com', password: 'password', role: 'moderator')
User.create!(email: 'member@example.com', password: 'password', role: 'member')
User.create!(email: 'user@example.com', password: 'password', role: 'user')
User.create!(email: 'userfr@example.com', password: 'password', role: 'user', name: '', country: '', city: '', profession: '', phone_number: '', bio: '', )
User.create!(email: 'userbe@example.com', password: 'password', role: 'user', name: '', country: '', city: '', profession: '', phone_number: '', bio: '', )
User.create!(email: 'userdz@example.com', password: 'password', role: 'user', name: '', country: '', city: '', profession: '', phone_number: '', bio: '', )
User.create!(email: 'userit@example.com', password: 'password', role: 'user', name: '', country: '', city: '', profession: '', phone_number: '', bio: '', )

