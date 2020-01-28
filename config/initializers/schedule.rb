require 'rubygems'
require 'rake'
require 'rufus/scheduler'

Awesomeapp::Application.load_tasks
load File.join( Rails.root, 'lib', 'tasks', 'hackernews_reloaded.rake')

scheduler = Rufus::Scheduler.new

scheduler.every '24h' do
  Rake::Task['hackernews_reloaded:delete_all_articles'].invoke
  Rake::Task['hackernews_reloaded:import_articles_from_all_categories'].invoke
end
