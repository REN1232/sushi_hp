# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 Admin.create(
 	email: "sushi@co.jp",
 	password: "sushisushi"
	)

Faker::Config.locale = :ja

50.times do |n|

	image = File.open("./app/assets/images/image11.jpg")
	title = "ブログ始めました#{n}回目"
	content = "本日のおすすめはこちらにのネタになります。ネタは、毎朝築地市場で買い上げた鮮魚のみを使用しています。#{n}回目"
  	Notice.create(
  		image: image,
  		title: title,
  		content: content
  		)
end

30.times do |n|

	customer_name = Faker::Name.name
	people = Faker::Number.between(from: 0, to: 9)
	reservation_time = ["11:00", "12:00", "13:00", "14:00", "17:00", "18:00", "19:00", "20:00", "21:00",].sample
	reservation_day = Faker::Date.forward(days: 30)
	phone_number = Faker::Number.number(digits: 10)
	email = Faker::Internet.email
	request = Faker::Food.sushi + "のアレルギーの方がいますので何か違う料理に変更お願いします。"
  	Reservation.create(
  		customer_name: customer_name,
  		people: people,
  		reservation_time: reservation_time,
  		reservation_day: reservation_day,
  		phone_number: phone_number,
  		email: email,
  		request: request
  		)
end

100.times do |n|

	customer_name = Faker::Name.name
	people = Faker::Number.between(from: 0, to: 9)
	reservation_time = ["11:00", "12:00", "13:00", "14:00", "17:00", "18:00", "19:00", "20:00", "21:00",].sample
	reservation_day = Faker::Date.forward(days: 30)
	phone_number = Faker::Number.number(digits: 10)
	email = Faker::Internet.email
	request = ""
  	Reservation.create(
  		customer_name: customer_name,
  		people: people,
  		reservation_time: reservation_time,
  		reservation_day: reservation_day,
  		phone_number: phone_number,
  		email: email,
  		request: request
  		)
end