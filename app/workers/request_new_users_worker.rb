class RequestNewUsersWorker
  include Sidekiq::Worker

  def perform(*args)
    puts 'Hello world!...'
  end
end
