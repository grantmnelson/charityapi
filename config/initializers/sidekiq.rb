# Calculator: http://manuel.manuelles.nl/sidekiq-heroku-redis-calc/
# Update to Calculator: https://github.com/mperham/sidekiq/issues/117 (mperham's Sidekiq 4 note)

Sidekiq.configure_client do |config|
  # This should be one, unless a web process makes more than one call to Redis
  # Multiply this number * the number of worker_processes in config/unicorn.rb to see
  # how many Redis connections it takes up.

  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|

  # Sidekiq automatically calculates the size by taking the :concurrency value from
  # /app/config/sidekiq.yml and adding five (https://github.com/mperham/sidekiq/issues/117).
  # Do NOT change it unless you know what you're doing. Chances Are you want to increase
  # Redis Connections, Sidekiq Concurrency, Web or Worker Dynos, or the AR Connection pool
  # setting first / instead.

  # config.redis = { :size => 3 }

end
