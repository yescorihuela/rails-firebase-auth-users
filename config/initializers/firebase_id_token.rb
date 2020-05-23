FirebaseIdToken.configure do |config|
  config.project_ids = ['prebrainer']
  config.redis = Redis.new({ url: ENV.fetch('JOB_WORKER_URL') {'0.0.0.0'}, db: 10})
end