module Articles
  class Actions::GetStoryIds
    extend LightService::Action
    expects :category_name
    promises :story_ids

    executed do |context|
      category_name = context.category_name
      context.story_ids = Utils::ApiRequests.get_story_ids_by_category(category_name: category_name)
    end
  end
end
