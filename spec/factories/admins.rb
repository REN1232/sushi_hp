FactoryBot.define do
  factory :admin do
    email { "sushi@co.jp" }
    password { "sushisushi" }
    password_confirmation { "sushisushi" }
  end
end