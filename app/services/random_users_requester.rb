class RandomUsersRequester < ApplicationService
  def call
    random_users = JSON.parse(HTTP.get(ENV['RANDOMUSER_API_URL']))
    names = random_users['results'].map{|person| person }
    Rails.cache.write(:names, names, expires_in: 1.minutes)
  end
end