class CacheUsersReader < ApplicationService
  def call
    Rails.cache.read(:names)
  end
end