class RequestNewUsersWorker
  include Sidekiq::Worker

  def perform(*args)
    RandomUsersRequester.call
  end
end
