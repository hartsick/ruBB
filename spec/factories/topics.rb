FactoryBot.define do
  factory :topic do
    title { 'post your pups' }

    association :author, factory: :user

    with_post

    trait :with_post do
      after(:create) do |evaluator|
        create :post, topic: evaluator, body: 'this is a post body', author: evaluator.author, created_at: evaluator.created_at
      end
    end
  end
end
