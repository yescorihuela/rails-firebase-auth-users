class CacheUsersReader < ApplicationService
  def call(key)
    Redis.cache.read(key)
  end
end