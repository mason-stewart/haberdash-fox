preload_app true
worker_processes 3 # amount of unicorn workers to spin up
timeout 60         # restarts workers that hang for 60 seconds
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end