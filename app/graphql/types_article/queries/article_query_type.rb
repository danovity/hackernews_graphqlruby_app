# module TypesArticle
#   module Queries
#     class ArticleQueryType < Types::BaseObject
#       field :allArticles, [TypesArticle::ArticleType], null: false

#       def all_articles
#         Article.all
#       end
#     end
#   end
# end

TypesArticle::Queries::ArticleQueryType = GraphQL::ObjectType.define do
  field :allArticles, !types[TypesArticle::ArticleType] do
    resolve ->(_object, arguments, context) do
      Article.all
    end
  end
end
