FactoryBot.define do
  factory :topic do
    title { 'post your pups' }

    association :author, factory: :user

    with_post

    trait :with_post do
      after(:create) do |evaluator|
        create :post, topic: evaluator, author: evaluator.author
      end
    end
  end
end
