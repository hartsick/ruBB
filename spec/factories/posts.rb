FactoryBot.define do
  factory :post do
    body { 'love to post a lot' }
    
    association :topic
    association :author, factory: :user
  end
end
