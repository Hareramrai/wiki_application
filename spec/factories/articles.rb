FactoryGirl.define do
  factory :article do |a|
    a.title { Faker::Lorem.sentence }
    a.language { Faker::Lorem.word }
    a.body { Faker::Lorem.paragraph }
    a.user

    trait :markdown do 
      body { Faker::Markdown.block_code }
    end

    factory :article_with_tags do
      after(:create) do |article, evaluator|
        tags = create_list(:tag, 3)
        article.tags = tags
      end
    end
  end
end
