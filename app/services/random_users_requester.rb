class RandomUsersRequester < ApplicationService
  def call
    url_api = ENV['RANDOMUSER_API_URL']
    response = HTTP.get(url_api)
    if response.code == 200
      random_users = JSON.parse(response)
      results = random_users['results'].map{|person| person }
      Rails.cache.write(:results, results, expires_in: 1.minutes)
    else
      results = Rails.cache.read(:results)
      Rails.cache.write(:results, results, expires_in: 1.minutes)
    end
  end
end