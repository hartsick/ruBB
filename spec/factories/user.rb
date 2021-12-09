FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "piglet#{n}" }
    sequence(:email) { |n| "piglet#{n}@dog.com" }
    password { 'iamadog666pigletisname' }
  end
end
