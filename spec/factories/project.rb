FactoryBot.define do
  factory :project do
    name    	  { Faker::Name.name }
    owner_id      { FactoryBot.create(:user).id }
    description   { Faker::Lorem.sentence(3) }
    start_date	  { Faker::Date.forward(1) }
    due_date	  { Faker::Date.forward(20) }
    status		  { 'active' }
  end

  factory :invalid_project, class: Project do
  	name  { nil }
   end
end