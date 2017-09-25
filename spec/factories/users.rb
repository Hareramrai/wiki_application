FactoryGirl.define do
  factory :user do |u|
    u.email { Faker::Internet.unique.email }
    u.password "Passw0rd"
    u.password_confirmation  "Passw0rd"
  end
end