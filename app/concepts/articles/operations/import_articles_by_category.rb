module Articles
  class Operations::ImportArticlesByCategory
    extend LightService::Organizer

    def self.call(category_name:)
      with(category_name: category_name).reduce(
        Actions::GetStoryIds,
        Actions::ImportArticles
      )
    end
  end
end
