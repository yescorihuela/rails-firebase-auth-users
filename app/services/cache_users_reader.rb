class CacheUsersReader < ApplicationService
  def call
    Rails.cache.read(:results)
  end
end