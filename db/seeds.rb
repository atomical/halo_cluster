# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
exit(0) unless Rails.env.development?

password = Rails.application.secrets["admin_password"]
User.create(email: "adam.t.hallett@gmail.com", password: password)

Map.destroy_all
Map.create(name: "Bloodgulch", filename: "bloodgulch.map")