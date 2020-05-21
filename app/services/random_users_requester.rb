class RandomUsersRequester < ApplicationService
  def call
    url_api = ENV['RANDOMUSER_API_URL']
    http_config = {:read => 5, :write => 5, :connect => 5}
    begin
      response = HTTP.get(url_api).timeout(http_config)
    rescue
      Rails.logger.error("External API(#{url_api}) not responds...")
    else
      if response.code == 200
        random_users = JSON.parse(response)
        results = random_users['results']
        Rails.cache.write(:results, results, expires_in: 1.minutes)
      else
        Rails.logger.warning("Response code #{response.code} from API...")
        Rails.logger.warning("Not data for cache renewal, keeping the last ones...")
        results = Rails.cache.read(:results)
        Rails.cache.write(:results, results, expires_in: 1.minutes)
      end
    end
  end
end