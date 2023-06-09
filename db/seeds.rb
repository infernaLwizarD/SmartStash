# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_admin
  User.create!(
    role: 'admin',
    username: 'admin',
    password: ENV.fetch('DB_PASSWORD', nil),
    email: 'admin@admin.admin',
    confirmed_at: Time.zone.now
  )
end

create_admin
