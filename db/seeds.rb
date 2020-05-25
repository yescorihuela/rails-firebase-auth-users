# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts ("Creating test users...")

User.create!([{
  :email => 'test@gmail.com',
  :password => '123456'
},
{
  :email => 'yher136@gmail.com',
  :password => '123456'
}])

puts ("Users created successfully...")