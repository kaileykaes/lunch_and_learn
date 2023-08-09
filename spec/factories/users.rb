password_example = Faker::Internet.password 
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { password_example }
    password_confirmation { password_example }
  end
end
