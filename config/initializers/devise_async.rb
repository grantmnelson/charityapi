# Supported options: :resque, :sidekiq, :delayed_job
Devise::Async.backend = :sidekiq
Devise::Async.queue = :mailer
