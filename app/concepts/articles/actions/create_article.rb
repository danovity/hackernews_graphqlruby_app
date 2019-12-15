module Articles
  class Actions::CreateArticle
    extend LightService::Action
    expects :parsed_story_params, :hackernews_story_data

    executed do |context|
      hackernews_story_data = context.hackernews_story_data
      params = context.parsed_story_params

      article = Article.find_by(hackernews_article_id: hackernews_story_data["id"])

      if article.present?
        form = ArticleForm.new(article, params)
      else
        form = ArticleForm.new(Article.new, params)
      end

      form.save
    end
  end
end
