class ImportArticlesByCategoryWorker
  include Sidekiq::Worker

  def perform(category_name)
    Articles::Operations::ImportArticlesByCategory.call(category_name: category_name)
  end
end
