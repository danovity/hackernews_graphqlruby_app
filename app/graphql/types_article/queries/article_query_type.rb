TypesArticle::Queries::ArticleQueryType = GraphQL::ObjectType.define do
  connection :topStories, !TypesArticle::ArticleType.connection_type, "A list of the top stories" do
    resolve ->(_object, arguments, context) do
      Article.top_stories
    end
  end
  connection :bestStories, !TypesArticle::ArticleType.connection_type, "A list of the best stories" do
    resolve ->(_object, arguments, context) do
      Article.best_stories
    end
  end
  connection :newStories, !TypesArticle::ArticleType.connection_type, "A list of the new stories" do
    resolve ->(_object, arguments, context) do
      Article.new_stories
    end
  end
end
