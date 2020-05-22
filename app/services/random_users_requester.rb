class RandomUsersRequester < ApplicationService
  def call
    url_api = ENV['RANDOMUSER_API_URL']

    begin
      response = HTTP.timeout(3).get(url_api)
    rescue
      Rails.logger.error("External API(#{url_api}) not responds...")
    else
      if response.code == 200
        random_users = JSON.parse(response)
        results = random_users['results']
      else
        Rails.logger.warning("Response code #{response.code} from API...")
        Rails.logger.warning("Not data for cache renewal, keeping the last ones...")
        results = Rails.cache.read(:results)
      end
      Rails.cache.write(:results, results, expires_in: 1.minutes)
    end
  end
end