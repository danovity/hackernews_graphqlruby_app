TypesArticle::Queries::ArticleQueryType =
  GraphQL::ObjectType.define do
    connection :topStories,
               !TypesArticle::ArticleType.connection_type,
               'A list of the top stories' do
      resolve ->(_object, arguments, context) { Article.top_stories }
    end
    connection :bestStories,
               !TypesArticle::ArticleType.connection_type,
               'A list of the best stories' do
      resolve ->(_object, arguments, context) { Article.best_stories }
    end
    connection :newStories,
               !TypesArticle::ArticleType.connection_type,
               'A list of the new stories' do
      resolve ->(_object, arguments, context) { Article.new_stories }
    end
  end
