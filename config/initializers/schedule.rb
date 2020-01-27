# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# every 1.day, at: '1:00 am' do
#   rake "hackernews_reloaded:delete_all_articles"
#   rake "hackernews_reloaded:import_articles_from_all_categories"
# end

require 'rufus-scheduler'
require 'rubygems'

scheduler = Rufus::Scheduler.new

# ...

scheduler.every '1m' do
  # do something every 3 hours and 10 minutes
  rake "hackernews_reloaded:delete_all_articles"
  rake "hackernews_reloaded:import_articles_from_all_categories"
end
