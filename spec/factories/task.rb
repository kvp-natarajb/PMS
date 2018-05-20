FactoryBot.define do
  factory :task do
    name    	  { Faker::Name.name }
    owner_id      { User.last }
    project_id	  { FactoryBot.create(:project).id }
    description   { Faker::Lorem.sentence(3) }
    start_date	  { Faker::Date.forward(1) }
    due_date	  { Faker::Date.forward(20) }
    status		  { ['new_task', 'in_progress', 'done'].sample }
  end
end