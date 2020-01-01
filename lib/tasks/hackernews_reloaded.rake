namespace :hackernews_reloaded do
  desc 'Import Articles for All Categories'
  task import_articles_from_all_categories: :environment do
    ['top', 'best', 'new'].each do |category_name|
      puts "Started Importing Articles for Category: #{category_name}"
      ImportArticlesByCategoryWorker.perform_async(category_name)
    end
  end

  desc 'Delete All Articles'
  task delete_all_articles: :environment do
    Article.find_each(&:destroy)
  end
end
