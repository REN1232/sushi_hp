FactoryBot.define do
  factory :reservation do
  	customer_name {Faker::Name.name}
  	people {Faker::Number.between(from: 1, to: 10)}
  	reservation_time {"11:00"}
  	reservation_day {Faker::Date.forward(days: 100)}
  	phone_number {Faker::Number.number(digits: 10)}
  	email {Faker::Internet.email}
  end
end