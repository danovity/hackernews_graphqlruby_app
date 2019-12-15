module Articles
  class Actions::ImportArticles
    extend LightService::Action
    expects :story_ids, :category_name

    executed do |context|
      context.story_ids.each do |story_id|
        Operations::CreateArticle.call(story_id: story_id, category_name: context.category_name)
      end
    end
  end
end
