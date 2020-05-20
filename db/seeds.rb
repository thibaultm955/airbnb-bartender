# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

bartender_image_array = []

bartender_image_array << bartender1 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589953299/Bartender_1_xxvq13.jpg')
bartender_image_array << bartender2 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975347/Bartender_2_dzi4sc.jpg')
bartender_image_array << bartender3 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975347/Bartender_3_yt8f8l.jpg')
bartender_image_array << bartender4 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975347/Bartender_4_zghifo.jpg')
bartender_image_array << bartender5 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975347/Bartender_5_vdwxfg.jpg')
bartender_image_array << bartender6 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975347/Bartender_6_jpbpab.jpg')
bartender_image_array << bartender7 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975348/Bartender_7_wm9qi8.jpg')
bartender_image_array << bartender8 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975348/Bartender_8_nzb6vt.jpg')
bartender_image_array << bartender9 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975349/Bartender_9_mxeahc.jpg')
bartender_image_array << bartender10 = URI.open('https://res.cloudinary.com/dqwejtyhm/image/upload/v1589975350/Bartender_10_wmlc1q.jpg')

user_array = {email: [], password: [], first_name: [], last_name: [], address: []}
bartender_array = {price_per_day: [], specialty: [], description: []}
specialties = ["mojito", "beers", "cocktails", "mojito", "sangria", "daikiri", "virgin cocktails"]

10.times do
    user_array[:email] << Faker::Internet.email #=> "eliza@mann.net"
    user_array[:password] << Faker::Internet.password(min_length: 8)
    user_array[:first_name] << Faker::Name.first_name
    user_array[:last_name] << Faker::Name.last_name
    user_array[:address] << Faker::Address.full_address #=> "282 Kevin Brook, Imogeneborough, CA 58517"
    bartender_array[:price_per_day] << Faker::Number.decimal(l_digits: 2) #=> 11.88
    bartender_array[:specialty] << [specialties.sample]
    bartender_array[:description] << Faker::Lorem.paragraph_by_chars #=> "Truffaut stumptown trust fund 8-bit messenger bag portland. Meh kombucha selvage swag biodiesel. Lomo kinfolk jean shorts asymmetrical diy. Wayfarers portland twee stumptown. Wes anderson biodiesel retro 90's pabst. Diy echo 90's mixtape semiotics. Cornho."
end

i = 0
while i < 10
    user = User.create!(email: user_array[:email][i], password: user_array[:password][i], first_name: user_array[:first_name][i], last_name: user_array[:last_name][i], address: user_array[:address][i])
    bartender = Bartender.new(price_per_day: bartender_array[:price_per_day][i], specialty: bartender_array[:specialty][i], description: bartender_array[:description][i])
    bartender.user = user
    bartender.photo.attach(io: bartender_image_array[i], filename: "bartender_#{i}.png", content_type: 'image/png')
    bartender.save
    i += 1
end


