require 'rubygems'
require 'rake'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '35s' do
  Rake::Task['hackernews_reloaded:delete_all_articles'].invoke
  Rake::Task['hackernews_reloaded:import_articles_from_all_categories'].invok
end
