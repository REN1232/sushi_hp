FactoryBot.define do
  factory :reservation do
  	customer_name {Faker::Name.name}
  	people {Faker::Number.between(from: 1, to: 2)}
  	reservation_time {"11:00"}
  	reservation_day {Faker::Date.forward(days: 100)}
  	phone_number {Faker::Number.number(digits: 10)}
  	email {Faker::Internet.email}
  	trait :invalid do
      customer_name {nil}
    end
  end
end