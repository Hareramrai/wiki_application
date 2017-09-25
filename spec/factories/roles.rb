FactoryGirl.define do
  factory :role do
    trait :author do
      name 'Author'
    end
    
    trait :admin do
      name 'Admin'
    end

    trait :moderator do
      name 'Moderator'
    end
  end
end
