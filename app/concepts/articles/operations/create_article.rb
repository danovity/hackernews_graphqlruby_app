module Articles
  class Operations::CreateArticle
    extend LightService::Organizer

    def self.call(story_id:, category_name:)
      with(
        story_id: story_id,
        category_name: category_name
      ).reduce(
        Actions::GetStoryData,
        Actions::ParseStoryData,
        Actions::CreateArticle
      )
    end
  end
end
