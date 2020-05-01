FactoryBot.define do
  factory :notice do
  	image { Faker::Avatar.image}
    title  { Faker::Lorem.characters(number:5) }
    content { Faker::Lorem.characters(number:30) }
  end
end