FactoryBot.define do
  factory :user, class: User do
    email { 'test@gmail.com' }
    password_digest { BCrypt::Password.create('123456') }
  end
end