class FirebaseTasksForceWorker
  include Sidekiq::Worker

  def perform(*args)
    RailsFirebaseAuthUsers::Application.load_tasks
    Rake::Task['firebase:certificates:force_request'].execute
  end
end
