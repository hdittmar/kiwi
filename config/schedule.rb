env :PATH, ENV['PATH']

set :output, "cron_log.log"
set :environment, 'development'

every 1.day do
  rake "db:load_new"
end
