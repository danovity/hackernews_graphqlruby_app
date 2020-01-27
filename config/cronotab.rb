# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
# class TestJob
#   def perform
#     puts 'Test!'
#   end
# end
#
# Crono.perform(TestJob).every 2.days, at: '15:30'
#
require 'rake'

Rails.app_class.load_tasks

class ImportArticlesForAllCategories
  def perform
    Rake::Task['hackernews_reloaded:import_articles_from_all_categories'].invoke
  end
end

class DeleteAllArticles
  def perform
    Rake::Task['hackernews_reloaded:delete_all_articles'].invoke
  end
end

Crono.perform(DeleteAllArticles).every 1.days, at '01:00'
Crono.perform(ImportArticlesForAllCategories).every 30.seconds
