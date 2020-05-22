# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
User.destroy_all
Bartender.destroy_all
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
    bartender_array[:price_per_day] << Faker::Number.decimal(l_digits: 2) #=> 11.88
    bartender_array[:specialty] << [specialties.sample]
end

user_array[:address] << "56, rue Comhaire, Liège"
user_array[:address] << "Cantersteen 10, 1000 Bruxelles"
user_array[:address] << "8-12 Rue Boissy d'Anglas, 75008 Paris"
user_array[:address] << "20 Rue Hippolyte Flandrin, 69001 Lyon"
user_array[:address] << "Zeedijk 14, 1012 AX Amsterdam"
user_array[:address] << "Plaza de Sta. Ana, 14, 28012 Madrid"
user_array[:address] << "27 Avenue de Port en Dro, 56340 Carnac"
user_array[:address] << "18 Place Nouvelle Aventure, 59000 Lille"
user_array[:address] << "Pelgrimstraat 7, 2000 Antwerpen"
user_array[:address] << "104 Rue du Quesnoy, 59300 Valenciennes"
bartender_array[:description] << "Make super cocktail, in a funny way, all naked behind your bar for your birthday!"
bartender_array[:description] << "Great cocktails, only for squirrels, because squirrels are the best. If you're not dressed like a squirrel, please don't book me"
bartender_array[:description] << "I love jongle with your glasses. it's not my fault if they fall !! "
bartender_array[:description] << "I could be astronaut, or biologist, but my passion is cocktail! love the colored one, with little unicorns"
bartender_array[:description] << "My cocktails are all inspired by Snow Queen! a lot of ice, and blue gin. I can sing too and wear a blue skirt"
bartender_array[:description] << "Cocktail is coming!! King of the bar is here, and cocktails with the fire of the dragons. Poison only for King Geoffrey !"
bartender_array[:description] << "i can't say there is bad or good cocktails. There is cocktails for different tastes. If you don't like them, quit them!"
bartender_array[:description] << "2 fingers ? Oh.... you don't want whiskey first? I hope you have the reference. If not, sorry. I'm a bartender with a lot of humor, i can make some funny jokes for your guests"
bartender_array[:description] << "between two cocktails, i can dance the carioca, and makes swing your guests! I'm the Patrick swayze of the bar! Dirty dirty bartending!! we don't let cocktail in the corner !"
bartender_array[:description] << " I am master Yoda of the bar! the Force is with me, and i put it in every cocktails. After booking me, you will see jedis everywhere"

i = 0
while i < 10
    user = User.create!(email: user_array[:email][i], password: user_array[:password][i], first_name: user_array[:first_name][i], last_name: user_array[:last_name][i], address: user_array[:address][i])
    bartender = Bartender.new(price_per_day: bartender_array[:price_per_day][i], specialty: bartender_array[:specialty][i], description: bartender_array[:description][i])
    bartender.user = user
    bartender.photo.attach(io: bartender_image_array[i], filename: "bartender_#{i}.png", content_type: 'image/png')
    bartender.save
    i += 1
end


