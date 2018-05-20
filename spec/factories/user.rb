FactoryBot.define do
  factory :user do
    full_name     { Faker::Name.name }
    email         { Faker::Internet.email }
    password      { "Admin@123" }
    role		  { 'developer' }
  end

  factory :admin, class: User do
    full_name     { Faker::Name.name }
    email         { Faker::Internet.email }
    password      { "Admin@123" }
    role		  { 'admin' }
  end
end