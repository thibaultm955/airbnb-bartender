# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
test = {email: [], password: [], first_name: [], last_name: [], address: []}
25.times do
    test[:email] << Faker::Internet.email #=> "eliza@mann.net"
    test[:password] << Faker::Internet.password(min_length: 8) 
    test[:first_name] << Faker::Name.first_name
    test[:last_name] << Faker::Name.last_name
    test[:address] << Faker::Address.full_address #=> "282 Kevin Brook, Imogeneborough, CA 58517"
end


i = 0
while i < 25
    User.create!(email: test[:email][i], password: test[:password][i], first_name: test[:first_name][i], last_name: test[:last_name][i], address: test[:address][i])
    i += 1
end

.