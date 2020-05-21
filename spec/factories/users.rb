FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 6) }
  end
end